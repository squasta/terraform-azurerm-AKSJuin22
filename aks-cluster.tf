
#            _  __ _____    _____ _           _            
#      /\   | |/ // ____|  / ____| |         | |           
#     /  \  | ' /| (___   | |    | |_   _ ___| |_ ___ _ __ 
#    / /\ \ |  <  \___ \  | |    | | | | / __| __/ _ \ '__|
#   / ____ \| . \ ____) | | |____| | |_| \__ \ ||  __/ |   
#  /_/    \_\_|\_\_____/   \_____|_|\__,_|___/\__\___|_|   

# https://patorjk.com/software/taag/#p=display&f=Big&t=AKS%20Cluster                                                       

# More info about azurerm_kubernetes_cluster resource :
# see https://github.com/terraform-providers/terraform-provider-azurerm/blob/master/azurerm/resource_arm_kubernetes_cluster.go
# examples here : https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/kubernetes 
resource "azurerm_kubernetes_cluster" "Terra_aks" {
  name                      = var.cluster_name
  location                  = azurerm_resource_group.Terra_aks_rg.location
  resource_group_name       = azurerm_resource_group.Terra_aks_rg.name
  dns_prefix                = var.dns_name
  kubernetes_version        = var.kubernetes_version
  automatic_channel_upgrade = var.automatic_channel_upgrade # this feature can not be used with Azure Spot nodes
  # Enable Azure Policy  cf. https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes
  # azure_policy_enabled = var.enable-AzurePolicy
  enable_pod_security_policy = var.defaultpool-securitypolicy
  sku_tier                   = var.sku-controlplane # possible values are Free and Paid
  private_cluster_enabled    = var.enable-privatecluster
  # private_dns_zone_id = "" 
  # private_cluster_public_fqdn_enabled = false
  # If you want to define the resource group where the Kubernetes node should exist instead of default MC_.....
  # node_resource_group = ""

  # Enable HTTP Application routing (Ingress for Test and Dev only)
  http_application_routing_enabled = "false"

  depends_on = [azurerm_log_analytics_workspace.Terra-LogsWorkspace]

  default_node_pool {
    name                   = var.defaultpool-name
    node_count             = var.defaultpool-nodecount
    vm_size                = var.defaultpool-vmsize
    os_disk_size_gb        = var.defaultpool-osdisksizegb
    max_pods               = var.defaultpool-maxpods
    zones                  = var.defaultpool-availabilityzones
    enable_auto_scaling    = var.defaultpool-enableautoscaling
    min_count              = var.defaultpool-mincount
    max_count              = var.defaultpool-maxcount
    vnet_subnet_id         = azurerm_subnet.Terra_aks_subnet.id
    enable_host_encryption = "false"
    fips_enabled           = "false"
    ultra_ssd_enabled      = "false"
    upgrade_settings {
      max_surge = "1"
    }
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = data.azurerm_key_vault_secret.ssh_public_key.value
    }
  }

  windows_profile {
    admin_username = var.windows_admin_username
    # Windows admin password is stored as a secret in an Azure Keyvault. Check datasource.tf for more information
    admin_password = data.azurerm_key_vault_secret.windows_admin_password.value
  }

  network_profile {
    network_plugin = "azure" # Can be kubenet (Basic Network) or azure (=Advanced Network)
    # Optional. Network mode to be used with Azure CNI. Possible values are bridge and transparent
    # network_mode = ""
    # network_policy     = var.networkpolicy_plugin # Options are calico or azure - only if network plugin is set to azure
    dns_service_ip     = "10.0.0.10" # Required when network plugin is set to azure, must be in the range of service_cidr and above 1
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16" # Must not overlap any address from the VNet
    load_balancer_sku  = "standard"    # sku can be basic or standard. Here it an AKS cluster with AZ support so Standard SKU is mandatory
    # The outbound (egress) routing method which should be used for this Kubernetes Cluster. 
    # Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway
    outbound_type = "loadBalancer"
    # Optional : Possible values are IPv4 and/or IPv6. IPv4 must always be specified.load_balancer_profile {
    # To configure dual-stack networking ip_versions should be set to ["IPv4", "IPv6"]
     ip_versions = ["IPv4"]
    }
  

  # Config OMS agent for Telemetry / Observability
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.Terra-LogsWorkspace.id
  }

  # Enable Azure Container Instance as a Virtual Kubelet
  # aci_connector_linux {
  #   enabled = true
  #   # https://github.com/terraform-providers/terraform-provider-azurerm/issues/3998
  #   subnet_name = azurerm_subnet.Terra_aks_aci_subnet.name
  # }

  # Enable Azure Application Gateway Ingress Controller
  # cf. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#:~:text=An%20ingress_application_gateway-,block,-supports%20the%20following
  ingress_application_gateway {
    # gateway_id = ""                       # for Brownfield deployment if you already set up an Application Gateway
    gateway_name = "appgw-aks-april22" # Greenfield deployment, this gateway will be created in cluster resource group.
    # subnet_cidr = "10.252.0.0/16"
    subnet_id = azurerm_subnet.Terra_aks_appgw_subnet.id
  }

  # (Optional) Open Service Mesh add-on 
  # cf. https://docs.microsoft.com/en-us/azure/aks/open-service-mesh-about
  open_service_mesh_enabled = "false"

  # Enable Kubernetes RBAC 
  # role_based_access_control {
  #   enabled = true               # please do NOT set up RBAC to false !!!
  # }

  # If true local accounts will be disabled.
  # cf. https://docs.microsoft.com/en-us/azure/aks/managed-aad#disable-local-accounts


  # (Optional) Whether to enable run command for the cluster or not. Default to true
  run_command_enabled = true

  # Managed Identity is mandatory because Kubernetes will provision some Azure Resources like Azure Load Balancer, Public IP, Managed Disks... 
  # You can also use a Service Principal (but it more complicated). One of either identity or service_principal must be specified
  identity {
    type = "SystemAssigned"
  }


  # Optional. cf. https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver
  # cf. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#:~:text=SystemAssigned%2C%20UserAssigned.-,A,-key_vault_secrets_provider%20block%20supports
  # key_vault_secrets_provider {
  # secret_rotation_enabled = "true"
  # secret_rotation_interval = "2m"
  # }


  # Optional. 
  # kubelet_identity {
  # }


  # # maintenance Window. cf https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#:~:text=A%20maintenance_window-,block,-supports%20the%20following 
  # maintenance_window {
  # # cf. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#:~:text=An%20allowed-,block,-exports%20the%20following
  # allowed {
  #   day   = "Sunday"
  #   hours = [ 1,2 ]
  # }
  # # cf. https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#:~:text=A%20not_allowed-,block,-exports%20the%20following
  # not_allowed {
  #   start = "cf. https://datatracker.ietf.org/doc/html/rfc3339"
  #   end   = "cf. https://datatracker.ietf.org/doc/html/rfc3339"
  #  }
  # }

  tags = {
    Usage       = "Demo"
    Environment = "Demo"
  }
}



# AKS Agent node-pool cf. https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster_node_pool.html
# resource "azurerm_kubernetes_cluster_node_pool" "Terra-AKS-NodePools" {
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.Terra_aks.id
#   name                  = "spotspool"
#   depends_on            = [azurerm_kubernetes_cluster.Terra_aks]
#   node_count            = 1          # static number or initial number of nodes. Must be between 1 to 100
#   enable_auto_scaling   = true       # use this parameter if you want an AKS Cluster with Node autoscale. Need also min_count and max_count
#   min_count             = 0          # minimum number of nodes with AKS Autoscaler
#   max_count             = 3          # maximum number of nodes with AKS Autoscaler
#   vm_size               = "Standard_D5_v2"
#   availability_zones    = var.winpool-availabilityzones # example : [1, 2, 3]
#   os_type               = "Linux"        # Possible values :linux, windows
#   os_disk_size_gb       = 128
#   vnet_subnet_id = azurerm_subnet.Terra_aks_subnet.id
#   mode = "User"
#   # priority = Regular or Spot
#   priority = "Spot"                                     # not compatible with cluster autoupgrade
#   eviction_policy = "Delete"                            # possible value : Delete, Deallocate
#   spot_max_price  = "-1"
#   node_taints = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]
# }








#               _     _ _ _   _                         _                   _                          _ 
#      /\      | |   | (_) | (_)                       | |                 | |                        | |
#     /  \   __| | __| |_| |_ _  ___  _ __  _ __   __ _| |    _ __   ___   __| | ___   _ __   ___   ___ | |
#    / /\ \ / _` |/ _` | | __| |/ _ \| '_ \| '_ \ / _` | |   | '_ \ / _ \ / _` |/ _ \ | '_ \ / _ \ / _ \| |
#   / ____ \ (_| | (_| | | |_| | (_) | | | | | | | (_| | |   | | | | (_) | (_| |  __/ | |_) | (_) | (_) | |
#  /_/    \_\__,_|\__,_|_|\__|_|\___/|_| |_|_| |_|\__,_|_|   |_| |_|\___/ \__,_|\___| | .__/ \___/ \___/|_|
#                                                                                   | |                  
#                                                                                   |_|                 


# AKS Agent node-pool cf. https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster_node_pool.html
# resource "azurerm_kubernetes_cluster_node_pool" "Terra-AKS-NodePools" {
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.Terra_aks.id
#   name                  = var.windowspool-name
#   depends_on            = [azurerm_kubernetes_cluster.Terra_aks]
#   node_count            = var.windowspool-nodecount     # static number or initial number of nodes. Must be between 1 to 100
#   enable_auto_scaling   = var.winpool-enableautoscaling # use this parameter if you want an AKS Cluster with Node autoscale. Need also min_count and max_count
#   min_count             = var.winpool-mincount          # minimum number of nodes with AKS Autoscaler
#   max_count             = var.winpool-maxcount          # maximum number of nodes with AKS Autoscaler
#   vm_size               = var.windowspool-vmsize
#   availability_zones    = var.winpool-availabilityzones # example : [1, 2, 3]
#   os_type               = var.windowspool-ostype        # Possible values :linux, windows
#   os_disk_size_gb       = var.windowspool-osdisksizegb
#   # max_pods              = var.winpool-maxpods         # between 30 and 250. BUT must 30 max for Windows Node
#   vnet_subnet_id = azurerm_subnet.Terra_aks_subnet.id
#   node_taints    = var.winpool-nodetaints               # cf. https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
#   mode = "User"
#   # priority = Regular or Spot
#   priority = "Spot"                                     # not compatible with cluster autoupgrade
#   eviction_policy = "Delete"                            # possible value : Delete, Deallocate
#   spot_max_price  = "-1"
#   # node_labels = "kubernetes.azure.com/scalesetpriority:spot"
#   # node_taints = "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
# }




# Role Assignment to give AKS managed identity Contributor permissions on the ACI resource group - Required for Virtual Kubelet
# cf. https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal#delegate-access-to-other-azure-resources
# cf. https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal#azure-container-instances 
# resource "azurerm_role_assignment" "Terra-aks-aci-role" {
#   scope                = azurerm_resource_group.Terra_aks_rg.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_kubernetes_cluster.Terra_aks.kubelet_identity.0.object_id
# }


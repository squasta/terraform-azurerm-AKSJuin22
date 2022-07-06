## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.1.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 1.22.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.5.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.10.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.12.0 |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 1.22.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.5.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.Terra-Ingress-DNS-A-Record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_kubernetes_cluster.Terra_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_log_analytics_workspace.Terra-LogsWorkspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.Terra_aks_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.Terra-aks-aci_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Terra-aks-subnet-role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.Terra-aks-vnet-role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.Terra_aks_aci_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.Terra_aks_appgw_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.Terra_aks_bastion_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.Terra_aks_firewall_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.Terra_aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.Terra_aks_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [grafana_dashboard.Terra_grafana_dashboard](https://registry.terraform.io/providers/grafana/grafana/1.22.0/docs/resources/dashboard) | resource |
| [grafana_data_source.Terra_grafana_data_source_prometheus](https://registry.terraform.io/providers/grafana/grafana/1.22.0/docs/resources/data_source) | resource |
| [grafana_folder.Terra_grafana_folder](https://registry.terraform.io/providers/grafana/grafana/1.22.0/docs/resources/folder) | resource |
| [helm_release.Terra-Prometheus](https://registry.terraform.io/providers/hashicorp/helm/2.5.0/docs/resources/release) | resource |
| [helm_release.Terra_helm_release_grafana](https://registry.terraform.io/providers/hashicorp/helm/2.5.0/docs/resources/release) | resource |
| [kubernetes_ingress_v1.Terra-Ingress-Grafana](https://registry.terraform.io/providers/hashicorp/kubernetes/2.10.0/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace_v1.Terra_grafana_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.10.0/docs/resources/namespace_v1) | resource |
| [kubernetes_namespace_v1.Terra_prometheus_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.10.0/docs/resources/namespace_v1) | resource |
| [random_string.Terra-random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/0.7.2/docs/resources/sleep) | resource |
| [time_sleep.wait_60_seconds](https://registry.terraform.io/providers/hashicorp/time/0.7.2/docs/resources/sleep) | resource |
| [azurerm_key_vault.terraform_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.spn_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.spn_object_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.spn_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.ssh_public_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.windows_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_public_ip.Terra-Public-IP-AppGW](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_LogsWorkspaceName"></a> [LogsWorkspaceName](#input\_LogsWorkspaceName) | Variable to define the name of Log Analytics Workspace (used by Azure Monitor Logs) | `string` | `"AKS-LogsWorkspace"` | no |
| <a name="input_LogsWorkspaceSKU"></a> [LogsWorkspaceSKU](#input\_LogsWorkspaceSKU) | Variable to choose SKU Possible values : Free PerGB2018 PerNode Premium Standalone Standard CapacityReservation Unlimited Standalone = Pricing per Gb, PerNode = OMS licence More info : https://azure.microsoft.com/en-us/pricing/details/log-analytics/ | `string` | `"PerGB2018"` | no |
| <a name="input_LogsworkspaceDaysOfRetention"></a> [LogsworkspaceDaysOfRetention](#input\_LogsworkspaceDaysOfRetention) | Variable pour definir le nb de jours de rétention du workspaceOMS (Azure Logs Analytics) Possible values : 30 to 730 | `string` | `"30"` | no |
| <a name="input_a-record-dns-ingress"></a> [a-record-dns-ingress](#input\_a-record-dns-ingress) | n/a | `string` | `"demoingress1"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Linux nodes admin user name | `string` | `"aksadmin"` | no |
| <a name="input_aks_vnet_name"></a> [aks\_vnet\_name](#input\_aks\_vnet\_name) | n/a | `string` | `"aksvnet"` | no |
| <a name="input_automatic-channel-upgrade"></a> [automatic-channel-upgrade](#input\_automatic-channel-upgrade) | supported values are : patch, rapid, stable | `string` | `"patch"` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none | `string` | `"patch"` | no |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Azure Region where to deploy resources. Caution the region must support Availability Zone | `string` | `"westeurope"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AKS Cluster name | `string` | `"AKS-Stan1"` | no |
| <a name="input_defaultpool-availabilityzones"></a> [defaultpool-availabilityzones](#input\_defaultpool-availabilityzones) | availability zones of the region | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_defaultpool-enableautoscaling"></a> [defaultpool-enableautoscaling](#input\_defaultpool-enableautoscaling) | use this parameter if you want an AKS Cluster with Nodes autoscaling. | `bool` | `true` | no |
| <a name="input_defaultpool-maxcount"></a> [defaultpool-maxcount](#input\_defaultpool-maxcount) | number max of nodes in pool. can be between 2 to 99 | `number` | `"3"` | no |
| <a name="input_defaultpool-maxpods"></a> [defaultpool-maxpods](#input\_defaultpool-maxpods) | number max of pods per node. can be between 30 to 250 on Advanced Network deployment | `number` | `"100"` | no |
| <a name="input_defaultpool-mincount"></a> [defaultpool-mincount](#input\_defaultpool-mincount) | number min of nodes in pool. can be between 1 to 99 | `number` | `"1"` | no |
| <a name="input_defaultpool-name"></a> [defaultpool-name](#input\_defaultpool-name) | Name of cluster default linux nodepool | `string` | `"pool1"` | no |
| <a name="input_defaultpool-nodecount"></a> [defaultpool-nodecount](#input\_defaultpool-nodecount) | Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100 | `number` | `"1"` | no |
| <a name="input_defaultpool-osdisksizegb"></a> [defaultpool-osdisksizegb](#input\_defaultpool-osdisksizegb) | Size in GB of node OS disk | `number` | `"32"` | no |
| <a name="input_defaultpool-ostype"></a> [defaultpool-ostype](#input\_defaultpool-ostype) | can be linux or windows | `string` | `"linux"` | no |
| <a name="input_defaultpool-securitypolicy"></a> [defaultpool-securitypolicy](#input\_defaultpool-securitypolicy) | n/a | `bool` | `false` | no |
| <a name="input_defaultpool-type"></a> [defaultpool-type](#input\_defaultpool-type) | Possible values are AvailabilitySet and VirtualMachineScaleSets | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_defaultpool-vmsize"></a> [defaultpool-vmsize](#input\_defaultpool-vmsize) | Size of VM | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_dns-zone-name-for-ingress"></a> [dns-zone-name-for-ingress](#input\_dns-zone-name-for-ingress) | n/a | `string` | `"standemo.com"` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | AKS DNS name must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number. | `string` | `"aksstan1"` | no |
| <a name="input_enable-AzurePolicy"></a> [enable-AzurePolicy](#input\_enable-AzurePolicy) | n/a | `bool` | `false` | no |
| <a name="input_enable-privatecluster"></a> [enable-privatecluster](#input\_enable-privatecluster) | n/a | `bool` | `false` | no |
| <a name="input_grafana_admin_username"></a> [grafana\_admin\_username](#input\_grafana\_admin\_username) | Grafana admin name | `string` | `"Stan"` | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | n/a | `string` | n/a | yes |
| <a name="input_keyvault_rg"></a> [keyvault\_rg](#input\_keyvault\_rg) | KeyVault Resource Group and KeyVaultName | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes to deploy | `string` | `"1.21.2"` | no |
| <a name="input_networkpolicy_plugin"></a> [networkpolicy\_plugin](#input\_networkpolicy\_plugin) | Supported values are calico or azure | `string` | `"azure"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource Group Name | `string` | `"RG-AKSCluster"` | no |
| <a name="input_rg-name-dns-zone-for-ingress"></a> [rg-name-dns-zone-for-ingress](#input\_rg-name-dns-zone-for-ingress) | n/a | `string` | `"rg-azuredns"` | no |
| <a name="input_sku-controlplane"></a> [sku-controlplane](#input\_sku-controlplane) | sku of Azure managed K8S control plane Free = no SLA, SLO 99.5, Paid = SLA 99.95 with AS, 99.99 with AZ | `string` | `"Free"` | no |
| <a name="input_windows_admin_username"></a> [windows\_admin\_username](#input\_windows\_admin\_username) | Windows Nodes admin user name | `string` | `"winadmin"` | no |
| <a name="input_windowspool-name"></a> [windowspool-name](#input\_windowspool-name) | Name of cluster windows nodepool | `string` | `"pool2"` | no |
| <a name="input_windowspool-nodecount"></a> [windowspool-nodecount](#input\_windowspool-nodecount) | Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100 | `number` | `"1"` | no |
| <a name="input_windowspool-osdisksizegb"></a> [windowspool-osdisksizegb](#input\_windowspool-osdisksizegb) | Size in GB of node OS disk | `number` | `"128"` | no |
| <a name="input_windowspool-ostype"></a> [windowspool-ostype](#input\_windowspool-ostype) | can be Linux or Windows | `string` | `"Windows"` | no |
| <a name="input_windowspool-type"></a> [windowspool-type](#input\_windowspool-type) | Possible values are AvailabilitySet and VirtualMachineScaleSets | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_windowspool-vmsize"></a> [windowspool-vmsize](#input\_windowspool-vmsize) | Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100 | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_winpool-availabilityzones"></a> [winpool-availabilityzones](#input\_winpool-availabilityzones) | availability zones of the region | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_winpool-enableautoscaling"></a> [winpool-enableautoscaling](#input\_winpool-enableautoscaling) | use this parameter if you want an AKS Cluster with Nodes autoscaling. | `bool` | `true` | no |
| <a name="input_winpool-maxcount"></a> [winpool-maxcount](#input\_winpool-maxcount) | number max of nodes in pool. can be between 2 to 99 | `number` | `"3"` | no |
| <a name="input_winpool-maxpods"></a> [winpool-maxpods](#input\_winpool-maxpods) | number max of pods per node. can be between 30 to 250 on Advanced Network deployment | `number` | `"30"` | no |
| <a name="input_winpool-mincount"></a> [winpool-mincount](#input\_winpool-mincount) | number min of nodes in pool. can be between 1 to 99 | `number` | `"1"` | no |
| <a name="input_winpool-nodetaints"></a> [winpool-nodetaints](#input\_winpool-nodetaints) | A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule) | `list(string)` | <pre>[<br>  "os=windows:NoSchedule"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_URL-to-connect-Grafana-through-AppGW-Ingress"></a> [URL-to-connect-Grafana-through-AppGW-Ingress](#output\_URL-to-connect-Grafana-through-AppGW-Ingress) | n/a |

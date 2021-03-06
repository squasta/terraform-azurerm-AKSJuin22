#                                    _                                             _       _   _           __          __        _                             
#      /\                          | |                          /\               | |     | | (_)          \ \        / /       | |                            
#     /  \    _____   _ _ __ ___   | |     ___   __ _ ___      /  \   _ __   __ _| |_   _| |_ _  ___ ___   \ \  /\  / /__  _ __| | _____ _ __   __ _  ___ ___ 
#    / /\ \  |_  / | | | '__/ _ \  | |    / _ \ / _` / __|    / /\ \ | '_ \ / _` | | | | | __| |/ __/ __|   \ \/  \/ / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \
#   / ____ \  / /| |_| | | |  __/  | |___| (_) | (_| \__ \   / ____ \| | | | (_| | | |_| | |_| | (__\__ \    \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/
#  /_/    \_\/___|\__,_|_|  \___|  |______\___/ \__, |___/  /_/    \_\_| |_|\__,_|_|\__, |\__|_|\___|___/     \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___|
#                                                __/ |                               __/ |                                              | |                   
#                                               |___/                               |___/                                               |_|                   
# ----------------------------------------------------
# this Terraform File will deploy :
# - an Azure Logs Analytics Workspace (cf. https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-overview)
# - Output all usefull informations including Azure Logs Analytics Portal URL
# more information : https://www.terraform.io/docs/providers/azurerm/r/log_analytics_workspace.html
# Variable are defined in var-AzureLogsAnalytics-Workspace.tf
# ----------------------------------------------------

resource "azurerm_log_analytics_workspace" "Terra-LogsWorkspace" {
  name                = "${var.LogsWorkspaceName}-${random_string.Terra-random.result}"
  location            = azurerm_resource_group.Terra_aks_rg.location
  resource_group_name = azurerm_resource_group.Terra_aks_rg.name

  # Possible values : PerNode, Standard, Standalone
  # Standalone = Pricing per Gb, PerNode = OMS licence 
  # More info : https://azure.microsoft.com/en-us/pricing/details/log-analytics/
  sku = var.LogsWorkspaceSKU

  # Possible values : 30 to 730
  retention_in_days = var.LogsworkspaceDaysOfRetention
}

# resource "azurerm_log_analytics_solution" "Terra-Analytics-Containers" {
#   solution_name         = "Containers"
#   location              = azurerm_resource_group.Terra_aks_rg.location
#   resource_group_name   = azurerm_resource_group.Terra_aks_rg.name
#   workspace_resource_id = azurerm_log_analytics_workspace.Terra-LogsWorkspace.id
#   workspace_name        = azurerm_log_analytics_workspace.Terra-LogsWorkspace.name

#   plan {
#     publisher = "Microsoft"
#     product   = "OMSGallery/Containers"
#   }
# }


# Output post deployment
# output "AzureLogAnalyticsWorkspaceID" {
#   value = azurerm_log_analytics_workspace.Terra-OMSWorkspace-SpecialK.id
# }

# output "AzureLogAnalyticsWorkspaceCustomerID" {
#   value = azurerm_log_analytics_workspace.Terra-OMSWorkspace-SpecialK.workspace_id
# }

# output "AzureLogAnalyticsWorkspaceprimarySharedKey" {
#   value = azurerm_log_analytics_workspace.Terra-OMSWorkspace-SpecialK.primary_shared_key
# }

# output "AzureLogAnalyticsWorkspaceSecondarySharedKey" {
#   value = azurerm_log_analytics_workspace.Terra-OMSWorkspace-SpecialK.secondary_shared_key
# }


# Variable to define the name of Log Analytics Workspace (used by Azure Monitor Logs)
variable "LogsWorkspaceName" {
  type    = string
  default = "AKS-LogsWorkspace"
}

# Variable to choose SKU 
# Possible values : Free PerGB2018 PerNode Premium Standalone Standard CapacityReservation Unlimited
# Standalone = Pricing per Gb, PerNode = OMS licence 
# More info : https://azure.microsoft.com/en-us/pricing/details/log-analytics/
variable "LogsWorkspaceSKU" {
  type    = string
  default = "PerGB2018"
}

# Variable pour definir le nb de jours de rétention du workspaceOMS (Azure Logs Analytics)
# Possible values : 30 to 730
variable "LogsworkspaceDaysOfRetention" {
  type    = string
  default = "30"
}

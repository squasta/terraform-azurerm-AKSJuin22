#    _____            __                  
#   / ____|          / _|                 
#  | |  __ _ __ __ _| |_ __ _ _ __   __ _ 
#  | | |_ | '__/ _` |  _/ _` | '_ \ / _` |
#  | |__| | | | (_| | || (_| | | | | (_| |
#   \_____|_|  \__,_|_| \__,_|_| |_|\__,_|
#
# Simple Deployment with Helm
# Exposed on Internet using Azure Application Gateway Ingress Controller
# This is just a sample for testing

# Grafana admin name
variable "grafana_admin_username" {
  type    = string
  default = "Stan"
}


# cf. https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1
resource "kubernetes_namespace_v1" "Terra_grafana_namespace" {
  metadata {
    annotations = {
      name = "grafana"
    }
    labels = {
      mylabel = "grafana"
    }
    name = "grafana"
  }
}


# cf. https://github.com/bitnami/charts/tree/master/bitnami/grafana
resource "helm_release" "Terra_helm_release_grafana" {
  name       = "my-grafana-from-bitnami"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"
  namespace = kubernetes_namespace_v1.Terra_grafana_namespace.metadata[0].name
  #timeout    = 600

  set {
    name  = "admin.user"
    value = var.grafana_admin_username
  }

  set {
    name  = "admin.password"
    value = data.azurerm_key_vault_secret.grafana_admin_password.value
  }

  set {
    name  = "replicaCount"
    value = 1
  }

  set {
    name  = "persistence.enabled"
    value = true
  }

  set {
    name  = "persistence.storageClass"
    value = "default"
  }

  set {
    name  = "persistence.accessMode"
    value = "ReadWriteOnce"
  }

  set {
    name  = "persistence.size"
    value = "1Gi"
  }

  set {
    name = "service.type"
    #value = "LoadBalancer"
    value = "NodePort"
  }

  set {
    name  = "tolerations"
    value = "os=linux:NoSchedule"
  }
}

# small timer to wait the deployment of grafana pods
# cf. https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep
resource "time_sleep" "wait_60_seconds" {
  depends_on = [azurerm_kubernetes_cluster.Terra_aks, helm_release.Terra_helm_release_grafana ]
  create_duration = "180s"
}



# cf. https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1
resource "kubernetes_ingress_v1" "Terra-Ingress-Grafana" {
  metadata {
    # https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata
    name      = "ingress-grafana"
    namespace = kubernetes_namespace_v1.Terra_grafana_namespace.metadata[0].name
    annotations = {
      # "kubernetes.io/ingress.class" = "nginx"
      # pour AGIC : https://azure.github.io/application-gateway-kubernetes-ingress/annotations/
      # "kubernetes.io/ingress.class" = "azure/application-gateway"
    }
  }

  spec {
      # to get ingress classes on a Kubernetes cluster : kubectl get ingressclasses 
      ingress_class_name = "azure-application-gateway"
      default_backend {
      service {
        name = "my-grafana-from-bitnami"
        port {
          number = 3000
        }
      }
    }

    rule {
      host = "demoingress1.standemo.com"
      http {
        path {
          backend {
            service {
              name = "my-grafana-from-bitnami"
              port {
                number = 3000
              }
            }
          }
          path = "/*"
        }

      }
    }

    # tls {
    #   secret_name = "tls-secret"
    # }
  }
}


# cf. https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/data_source
# cf. https://github.com/grafana/terraform-provider-grafana/issues/63 

resource "grafana_folder" "Terra_grafana_folder" {
  title      = "My Folder created by Terraform"
  depends_on = [time_sleep.wait_60_seconds]
}


# cf. https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard
# Examples: cf. https://grafana.com/grafana/dashboards
resource "grafana_dashboard" "Terra_grafana_dashboard" {
  config_json = file("kubernetes-apiserver_rev1.json")
  folder = grafana_folder.Terra_grafana_folder.id
  depends_on = [time_sleep.wait_60_seconds]
}

resource "grafana_data_source" "Terra_grafana_data_source_prometheus" {
  type = "prometheus"
  name = "AKS_prometheus"
  url  = "http://prometheus-server.prometheus.svc.cluster.local/"
  depends_on = [time_sleep.wait_60_seconds]

}
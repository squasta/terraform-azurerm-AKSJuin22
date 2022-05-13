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



# cf. https://github.com/bitnami/charts/tree/master/bitnami/grafana
resource "helm_release" "Terra-grafana2" {
  name       = "my-grafana-from-bitnami"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana"
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

# cf. https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1
resource "kubernetes_ingress_v1" "Terra-Ingress-Grafana" {
  metadata {
    # https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata
    name      = "ingress-grafana"
    namespace = "default"
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

        # path {
        #   backend {
        #   }
        #   path = "/app2/*"
        # }
      }
    }

    # tls {
    #   secret_name = "tls-secret"
    # }
  }
}

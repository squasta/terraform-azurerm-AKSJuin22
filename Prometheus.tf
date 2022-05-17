
# Prometheus namespace
# cf. https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1
resource "kubernetes_namespace_v1" "Terra_prometheus_namespace" {
  metadata {
    annotations = {
      name = "prometheus"
    }
    labels = {
      mylabel = "prometheus"
    }
    name = "prometheus"
  }
}

# https://github.com/prometheus-community/helm-charts
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
resource "helm_release" "Terra-Prometheus" {
  depends_on = [kubernetes_ingress_v1.Terra-Ingress-Grafana, azurerm_dns_a_record.Terra-Ingress-DNS-A-Record]
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  #timeout    = 600
  namespace = kubernetes_namespace_v1.Terra_prometheus_namespace.metadata[0].name
  #   set {
  #   name  = "namespace"
  #   value = kubernetes_namespace_v1.Terra_prometheus_namespace.metadata[0].name
  # }
}



# # cf. https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1
# resource "kubernetes_ingress_v1" "Terra-Ingress-Prometheus" {
#   metadata {
#     # https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata
#     name      = "ingress-prometheus"
#     namespace = kubernetes_namespace_v1.Terra_prometheus_namespace.metadata[0].name
#     annotations = {
#       # "kubernetes.io/ingress.class" = "nginx"
#       # pour AGIC : https://azure.github.io/application-gateway-kubernetes-ingress/annotations/
#       # "kubernetes.io/ingress.class" = "azure/application-gateway"
#     }
#   }

#   spec {
#       # to get ingress classes on a Kubernetes cluster : kubectl get ingressclasses 
#       ingress_class_name = "azure-application-gateway"
#       default_backend {
#       service {
#         name = "prometheus-server"
#         port {
#           number = 80
#         }
#       }
#     }

#     rule {
#       http {
#         path {
#           backend {
#             service {
#               name = "prometheus-server"
#               port {
#                 number = 80
#               }
#             }
#           }
#           path = "/*"
#         }

#         # path {
#         #   backend {
#         #   }
#         #   path = "/app2/*"
#         # }
#       }
#     }

#     # tls {
#     #   secret_name = "tls-secret"
#     # }
#   }
# }





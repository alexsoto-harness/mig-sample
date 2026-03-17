# MIG Sample

Google Cloud Managed Instance Group (MIG) deployment using Harness CD.

## Structure

```
mig/                        # GCP MIG configuration files
  instance-template.json    # VM instance template (e2-micro, Debian 12)
  mig-config.json           # MIG group configuration (update policy, target size)

.harness/                   # Harness resource definitions
  service.yaml              # MIG service definition with manifests + GCE artifact
  environment.yaml          # Pre-production environment
  infrastructure.yaml       # GCP infrastructure (sales-209522, us-central1-a)
  pipeline.yaml             # Standard MIG deployment pipeline
```

## Prerequisites

- Harness account with `CDS_GOOGLE_MIG` feature flag enabled
- GCP connector (`account.Harness_GCP`)
- Kubernetes connector (`Harness_GKE`) for container step group
- Docker connector (`Docker_Harness`) for pulling MIG plugin images
- GitHub connector (`Github_Harness`) for manifest fetching

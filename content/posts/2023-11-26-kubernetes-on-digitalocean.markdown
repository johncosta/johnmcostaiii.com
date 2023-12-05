---
title: "Kubernetes on DigitalOcean"
date: "2023-12-05"
comments: true
tags: ["managed", "kubernetes", "digitalocean", "DevOps"]
---

# Overview
Recently, I've been working on a project, a part of which is to deploy a Kubernetes cluster.  I was hoping to
document the process so that it could save some time for my future self and maybe others.

This post is the first in a series of posts which will document the process I went through to get a Kubernetes cluster
up and running. In addition to documenting the process, I'll be creating a repository which will contain the code I used
to create the cluster. The repository is available [here](https://github.com/johncosta/terraform-digitalocean-kubernetes).

## TLDR;

I'm using:
* DigitalOcean to host my Kubernetes cluster
* Terraform to manage the infrastructure
* Spaces for object storage
* tfenv to manage terraform versions
* tgenv to manage terragrunt versions

## Hosting Platform

Based on the cost estimates for what I was looking to do, I decided to go with DigitalOcean.  I've used DigitalOcean in
the past and have been happy with the service.  I also like the simplicity of the platform and the user interface.
More importantly, I like that they have a managed Kubernetes offering.

If you'd like to read more about the cost estimates for my project, you can read more about it
[here](/posts/2023-11-26-kubernetes-hosting).

## Kubernetes Cluster

Building up a kubernetes cluster is documented pretty thoroughly in the tutorials on DigitalOcean's site[^1].  After
working through some of the setup steps, I realized that there could be a quicker way to get a cluster up and running
using Terraform, by deferring the control plane setup to DigitalOcean.  This would allow me to get a cluster up and
running quickly, and then if it made sense I could work on automating the setup of the control plane later.  It helps
that they don't charge for the control plane.

## Infrastructure Management

Terraform is my go-to tool for infrastructure management. I've used it in the past to manage infrastructure on AWS, GCP,
and DigitalOcean. Given my familiarity with the tool, I decided to use it to manage the infrastructure for my Kubernetes
cluster.

Though there's a kerfuffle with Hashicorp's open source licencing[^2], I still decided to use Terraform, at least to
start. I assume that there will be a migration path eventually to OpenToFu, but again I'd like to get up and running as
fast as reasonable.

## Spaces

One of the requirements to using terraform is that there needs to be a way to manage state of the remote objects. Keeping
the state locally is not a good idea, as it can be lost or corrupted.  Keeping the state in the cloud is a better.

Terraform keeps track of the state of the infrastructure it manages in a file, usualy named `terraform.tfstate`.  This
file is used to determine what changes need to be made to the infrastructure to bring it in line with the desired state.

Some resources already exist which walks through the setup[^3][^4] of Spaces.

### Spaces Setup

Digital Ocean has a pretty good tutorial on how to setup Spaces.  I'll walk through the steps I took to get it setup but
if you're new to DigitalOcean I'd recommend following their tutorial.[^5]

As a quick overview, the steps are:

1) Create a Space bucket in the console.  This is typically a one time step depending on how you want to scale your projects. It's as straighforward as setting the region and name of the space.  I chose to use the default region of
 `nyc3`.

2) Create a new Spaces Access Key and Secret.  This is also a one time step assuming you back up your key.  The access
key is used to authenticate with the space.

### Configuring Terraform to use Spaces

Once the space is set up, you'll need to configure Terraform to use it.  This is done by adding a backend configuration
to the `provider.tf` file.  The backend configuration tells Terraform where to store the state file.  In this case,
we're telling Terraform to store the state file in the space we created earlier.  A simple version of the configuration
looks like this:

```hcl
terraform {
  required_version = "~> v1.6.0"

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.32.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
  spaces_access_id  = "<access key>"
  spaces_secret_key = "<access key secret>"
}
```

In addition to the backend configuration, we also need to configure the DigitalOcean backend. The spaces access key and
secret are used to authenticate with the space.

```hcl
terraform {
    backend "s3" {
      key      = "<SPACES KEY>"
      bucket   = "<SPACES BUCKET>"
      region   = "nyc3"
      endpoints = { s3 = "https://nyc3.digitaloceanspaces.com" }

      encrypt                     = true

      # The following are currently required for Spaces
      # See: hashicorp/terraform#33983 and hashicorp/terraform#34086
      skip_region_validation      = true
      skip_credentials_validation = true
      skip_metadata_api_check     = true
      skip_requesting_account_id  = true
      skip_s3_checksum            = true
  }
}

```

### Creating the cluster

Once the backend is configured, we can create the cluster.  The cluster is created using the `digitalocean_kubernetes_cluster`
resource.  You'll note that I'm glossing over some of the details in the configuration.  I'll go into more detail in a
later post.

If you're looking for a working example, you can find one in the [terraform-digitalocean-kubernetes](https://github.com/johncosta/terraform-digitalocean-kubernetes) repository.

```hcl
resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "<NAME>"
  region  = "<REGION>"
  version = "<VERSION>"

  # fixed node size
  node_pool {
    name       = "<POOL NAME>"
    size       = "<INSTANCE SIZE>"
    node_count = "<NODE COUNT>"
  }
}
```

[^1]: https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-20-04
[^2]: https://opentofu.org/blog/the-opentofu-fork-is-now-available/
[^3]: https://anichakraborty.medium.com/terraform-remote-state-backup-with-digital-ocean-spaces-697e35128a6a
[^4]: https://adamtheautomator.com/digitalocean-spaces/
[^5]: https://docs.digitalocean.com/developer-center/onboarding-how-to-use-digitalocean-spaces/

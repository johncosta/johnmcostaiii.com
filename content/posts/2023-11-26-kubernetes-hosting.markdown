---
title: "Kuberentes Hosting Services"
date: "2023-11-26"
comments: true
tags: ["managed", "kubernetes", "aws", "amazon", "gcp", "google cloud platform", "azure", "digitalocean", "DevOps"]
---

# Overview
When looking for a hosting platform for Kubernetes, I wanted to find a platform which was easy to use, had a good
developer experience, and that was cost-effective. Easy to use is somewhat subjective and certainly depends on
familiarity with the platform, domain knowledge, and other factors. Therefor, I'll try to be as objective as possible
when evaluating the platforms looking at Developer Experience and Cost Effectiveness.

For others, there could be other dimensions which are more important. For example, if you're looking to meet certain
compliance requirements, you might want to look at the security and compliance features of the platform and rate them
accordingly.

For me and my project, these are not yet siginificant concerns.

## Hosting Platform Options
An AI Assisted search via OpenAI's ChatGPT[^7] for Kubernetes hosting platforms yields the following results:

| Hosting Provider  | Cost Effectiveness                                                                                                                                | Developer Experience                                                                                                                       |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| AWS               | - Components: EC2, S3, RDS, Lambda, etc.<br> - Pricing: Pay-as-you-go model, variable costs                                                       | - Productivity: High<br> - Impact: Broad range of services<br> - Satisfaction: Generally positive                                          |
| Google Cloud      | - Components: Compute Engine, Cloud Storage, BigQuery, etc.<br> - Pricing: Sustained use discounts, per-minute billing                            | - Productivity: High<br> - Impact: Advanced AI and ML capabilities<br> - Satisfaction: Positive developer tools                            |
| DigitalOcean      | - Components: Droplets, Spaces, Databases, etc.<br> - Pricing: Simple and transparent pricing, fixed monthly costs                                | - Productivity: Moderate (simplified services)<br> - Impact: Suitable for smaller projects<br> - Satisfaction: Good user interface         |
| Azure             | - Components: Virtual Machines, Blob Storage, Azure SQL Database, etc.<br> - Pricing: Flexible pricing options, Hybrid Benefit for Windows Server | - Productivity: High<br> - Impact: Integration with Microsoft products<br> - Satisfaction: Depends on familiarity with Microsoft ecosystem |

Query:
```text
create a markdown table which includes the following hosting providers:
AWS
Google Cloud
DigitalOcean
Azure

use the following columns so that each option could be evaluated:
- developer experience
- cost effectiveness

developer experience should include productivity, impact, satisfaction
cost effectiveness should include components and pricing for those components
```

## Validating the Findings

### Cost Effectiveness

The following are specifications for a development environment. The goal is to have a non-high availablilty Kubernetes
cluster with 2 worker nodes intended for a development environment. The cluster should have a managed control plane and
managed worker nodes, and should have object storage and load balancing. The cluster should also have a managed Kafka
instance.

Pricing has been calculated generally using two worker nodes, and the cheapest option for the managed control plane.

Monthly Pricing (as of November 2023[^6]):

| Aspect                | AWS[^1]        | Google Cloud[^2] | DigitalOcean[^3] | Azure[^4]      |
|-----------------------|----------------|------------------|------------------|----------------|
| Managed Control Plane | 73.00 USD      | 73.00 USD        | 00.00 USD        | 73.00 USD      |
| Managed Worker Nodes  | 27.45 USD      | 97.09 USD        | 36.00 USD        | 175.20 USD     |
| Object Storage        | 00.02 USD      | 0.023 USD        | 05.00 USD        | 52.41 USD      |
| Load Balancing        | 31.03 USD      | 18.27 USD        | 12.00 USD        | 23.25 USD      |
| Managed Kafka         | 86.58 USD      | 31.13 USD        | 15.00 USD        | 10.95 USD      |
| Managed Database      | 69.15 USD      | 25.55 USD        | 15.00 USD        | 24.82 USD      |
| **Total**             | **287.23 USD** | **245.97 USD**   | **83.00 USD**    | **359.63 USD** |

### Developer Experience
GitHub mentions Developer Experience (DevEx)[^5] as productivity, impact, and satisfaction. My thought is to document my
experience so that other's can evaluate the platforms for themselves.

Given the pricing schedule above, it's not currently pheasable for me to fully evaluate all the platforms at the same
time.  Instead, I'll focus on the most cost-effective one, DigitalOcean. If given the opportunity and necessesity, I'll
evaluate the other platforms in the future.

In a follow-up article, I'll report my observations and experience. For now, I'll leave this as a placeholder.

Thanks for reading!

[^1]: https://calculator.aws/#/estimate. 2 t3a.small nodes as workers
[^2]: https://cloud.google.com/products/calculator. 2 n1-standard-2 nodes as workers
[^3]: https://www.digitalocean.com/pricing/. 2 Standard Droplets as workers, 1GB of object storage
[^4]: https://azure.microsoft.com/en-au/pricing/calculator/.
[^5]: https://github.blog/2023-06-08-developer-experience-what-is-it-and-why-should-you-care/
[^6]: For expediency, I've tried to choose similar services across the platforms. A better evaluation might detail the
precise specifications of each service.  For expediency, I've chosen to leave out some of these details and could
backfill them if they became more relevant.
[^7]: https://chat.openai.com/

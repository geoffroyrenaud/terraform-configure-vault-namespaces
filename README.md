# terraform-configure-vault-namespaces
Terraform code in order to configure Vault namespaces at sclale

## POC

In order to correctly managed Hashicorp Vault, we will use Terraform with Vault provider in order to manage all Vault configuration lifecycle.

On this way, there is some difficulities with terraform vault providers and namespaces management :
* [vault_namespace](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/namespace) resource can't configure an absolute namespace path, you need to be on parent namespace to create children.
* using yaml, json, csv decode function + for_each in a terraform module (since terraform v0.13+) doesn't work with dynamic namespace provider configuration.
* making a terraform wrapper with dynamic configuation of VAULT_NAMESPACE + terraform workspace new/select will fail with a wrong policy token (you'll obtain only 'default' policy for the token-terraform used by terraform, so no rights) when you are in another namespace than root (provider.vault v2.14.0)

Due to thoses limitations, here a *Proof of Concept* about using python parser in order to write terraform code.


## Usage

* namespaces.txt configure file
```
ns1
ns1/ns1a
ns1/ns1a/ns1aa
ns1/ns1a/ns1ab
ns2
ns2/ns2a
ns2/ns2b
ns3

```
* how to run the script
```
python3 ./make_tf_vault_ns.py
```

* terraform code result example :
```
# NS ns1
provider vault {
  alias = "ns1"
  namespace = "ns1"
}
resource vault_namespace ns_ns1 {
  provider = "vault"
  path = "ns1"
}

# NS ns1/ns1a
provider vault {
  alias = "ns1-ns1a"
  namespace = "ns1/ns1a"
}
resource vault_namespace ns_ns1-ns1a {
  provider = "vault.ns1"
  path = "ns1a"
}

# NS ns1/ns1a/ns1aa
provider vault {
  alias = "ns1-ns1a-ns1aa"
  namespace = "ns1/ns1a/ns1aa"
}
resource vault_namespace ns_ns1-ns1a-ns1aa {
  provider = "vault.ns1-ns1a"
  path = "ns1aa"
}

# NS ns1/ns1a/ns1ab
provider vault {
  alias = "ns1-ns1a-ns1ab"
  namespace = "ns1/ns1a/ns1ab"
}
resource vault_namespace ns_ns1-ns1a-ns1ab {
  provider = "vault.ns1-ns1a"
  path = "ns1ab"
}

# NS ns2
provider vault {
  alias = "ns2"
  namespace = "ns2"
}
resource vault_namespace ns_ns2 {
  provider = "vault"
  path = "ns2"
}

# NS ns2/ns2a
provider vault {
  alias = "ns2-ns2a"
  namespace = "ns2/ns2a"
}
resource vault_namespace ns_ns2-ns2a {
  provider = "vault.ns2"
  path = "ns2a"
}

# NS ns2/ns2b
provider vault {
  alias = "ns2-ns2b"
  namespace = "ns2/ns2b"
}
resource vault_namespace ns_ns2-ns2b {
  provider = "vault.ns2"
  path = "ns2b"
}

# NS ns3
provider vault {
  alias = "ns3"
  namespace = "ns3"
}
resource vault_namespace ns_ns3 {
  provider = "vault"
  path = "ns3"
}
```

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


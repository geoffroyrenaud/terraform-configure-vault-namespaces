#!/usr/bin/python3

tpl = """# NS {full_path}
provider vault {{
  alias = "{workspace}"
  namespace = "{full_path}"
}}
resource vault_namespace ns_{workspace} {{
  provider = "{provider}"
  path = "{children}"
}}

"""

fd = open("namespaces.txt")
tf = open("namespaces.tf", "w")
for l in fd.readlines():
    full_path = l.rstrip()
    workspace = full_path.replace("/", "-")
    print("workspace", workspace)
    parent_path = "/".join(full_path.split("/")[:-1])
    children = full_path.split("/")[-1]
    print("parent '{}' : to create : '{}'".format(parent_path, children))
    provider = "vault." + parent_path.replace("/", "-")
    if parent_path == "":
        provider = "vault"
    tf.write(tpl.format(full_path=full_path, workspace=workspace, children=children, parent_path=parent_path, provider=provider))

tf.close()
    

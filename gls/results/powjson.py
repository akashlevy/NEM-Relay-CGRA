import json
import powplot

# Helper class for parsing tree struction of power report
class Node:
    def __init__(self, row):
        self.children = []
        self.level = row["Indent"]
        self.module = row["Module"]
        self.intpow = row["Internal Power (mW)"]
        self.swpow = row["Switching Power (mW)"]
        self.leakpow = row["Leakage Power (mW)"]

    def add_children(self, nodes):
        childlevel = nodes[0].level
        while nodes:
            node = nodes.pop(0)
            if node.level == childlevel: # add node as a child
                self.children.append(node)
            elif node.level > childlevel: # add nodes as grandchildren of the last child
                nodes.insert(0, node)
                self.children[-1].add_children(nodes)
            elif node.level <= self.level: # this node is a sibling, no more children
                nodes.insert(0, node)
                return

    def as_dict(self):
        if len(self.children) >= 1:
            del self.intpow
            del self.swpow
            del self.leakpow
            return {"name" : self.module, "children" : [node.as_dict() for node in self.children]}
        else:
            return {"name": self.module, "children" : [
                {"name" : "Internal Power", "size" : self.intpow},
                {"name" : "Switching Power", "size" : self.swpow},
                {"name" : "Leakage Power", "size" : self.leakpow},
                ]}

# Load all files and convert to json
data = powplot.read_power_to_df("**/*.power.hier.rpt")
for fname, table in data.groupby("Filename"):
    jdata = []
    rows = list(table.iterrows())
    root = Node(rows[0][1])
    root.add_children([Node(row) for _, row in rows[1:]])
    with open(f"{fname}.json", "w") as outfile:
        json.dump(root.as_dict(), outfile)

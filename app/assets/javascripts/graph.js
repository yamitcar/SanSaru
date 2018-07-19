function populate_trees(){
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: 'data',
        dataType: 'json',
        success: function (data) {
            console.log(treeOne);
            draw(data[0],'.treeOne',treeOne);
            draw(data[1],'.treeTwo',treeTwo);
            draw(data[2],'.treeThree',treeThree);
        },
        error: function (result) {
            error(result);
        }
    });
}

function error(result) {
    console.log(result)
}

var margin = {top: 20, right: 150, bottom: 20, left: 200},
    width = 2000 - margin.right - margin.left,
    height = 800 - margin.top - margin.bottom;
var i = 0,
    duration = 750;

var treeOne = {
    root: null,
    tree: null,
    diagonal: null,
    svg:null
    }
var treeTwo = {
    root: null,
    tree: null,
    diagonal: null,
    svg:null
}
var treeThree = {
    root: null,
    tree: null,
    diagonal: null,
    svg:null
}



function draw(data,div,treeObj) {

// ************** Generate the tree diagram	 *****************
    treeObj.tree = d3.layout.tree()
        .size([height, width]);

    treeObj.diagonal = d3.svg.diagonal()
        .projection(function (d) {
            return [d.y, d.x];
        });

    treeObj.svg = d3.select(div).append("svg")
        .attr("width", width + margin.right + margin.left)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    treeObj.root = data;
    treeObj.root.x0 = height / 2;
    treeObj.root.y0 = 0;

    update(treeObj.root,treeObj);

}



function update(source,treeObj) {

    // Compute the new tree layout.
    var nodes = treeObj.tree.nodes(treeObj.root).reverse(),
        links = treeObj.tree.links(nodes);

    // Normalize for fixed-depth.
    nodes.forEach(function(d) { d.y = d.depth * 120; });

    // Update the nodes…
    var node = treeObj.svg.selectAll("g.node")
        .data(nodes, function(d) { return d.id || (d.id = ++i); });

    // Enter any new nodes at the parent's previous position.
    var nodeEnter = node.enter().append("g")
        .attr("class", "node")
        .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
        .on("click",  function (d) {
            click(d,treeObj);
        });

    nodeEnter.append("circle")
        .attr("r", 1e-6)
        .style("fill", function(d) {
            var color = d.payed ? "#00A354" : "#EC0404"
            return d._children ? "lightsteelblue" : color;
        });

    nodeEnter.append("text")
        .attr("x", function(d) { return d.children || d._children ? -13 : 13; })
        .attr("dy", ".35em")
        .attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
        .text(function(d) { return d.name; })
        .style("fill-opacity", 1e-6);

    // Transition nodes to their new position.
    var nodeUpdate = node.transition()
        .duration(duration)
        .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

    nodeUpdate.select("circle")
        .attr("r", 10)
        .style("fill", function(d) {
            var color = d.payed ? "#00A354" : "#EC0404"
            return d._children ? "lightsteelblue" : color;
        });

    nodeUpdate.select("text")
        .style("fill-opacity", 1);

    // Transition exiting nodes to the parent's new position.
    var nodeExit = node.exit().transition()
        .duration(duration)
        .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
        .remove();

    nodeExit.select("circle")
        .attr("r", 1e-6);

    nodeExit.select("text")
        .style("fill-opacity", 1e-6);

    // Update the links…
    var link = treeObj.svg.selectAll("path.link")
        .data(links, function(d) { return d.target.id; });

    // Enter any new links at the parent's previous position.
    link.enter().insert("path", "g")
        .attr("class", "link")
        .attr("d", function(d) {
            var o = {x: source.x0, y: source.y0};
            return treeObj.diagonal({source: o, target: o});
        });

    // Transition links to their new position.
    link.transition()
        .duration(duration)
        .attr("d", treeObj.diagonal);

    // Transition exiting nodes to the parent's new position.
    link.exit().transition()
        .duration(duration)
        .attr("d", function(d) {
            var o = {x: source.x, y: source.y};
            return treeObj.diagonal({source: o, target: o});
        })
        .remove();

    // Stash the old positions for transition.
    nodes.forEach(function(d) {
        d.x0 = d.x;
        d.y0 = d.y;
    });
}

// Toggle children on click.
function click(d,treeObj) {
    if (d.children) {
        d._children = d.children;
        d.children = null;
    } else {
        d.children = d._children;
        d._children = null;
    }
    update(d,treeObj);
}


let treeData = [
  {
  "name": "Операційна діяльність",
  "children": [
   {
    "name": "Проєктування",
    "children": [
     {"name": "jjj", "size": 1082},
     {"name": "jjj", "size": 1336},
     {"name": "jjj", "size": 319},
    ]
   },
   {
    "name": "Будівництво",
    "children": [
     {"name": "jjj", "size": 1616},
     {"name": "jjj", "size": 1027},
     {"name": "jjj", "size": 3891},
     {"name": "jjj", "size": 891},
    ]
    },
   {
    "name": "Облаштування, утримання та обслуговування території",
    "children": [
     {"name": "jjj", "size": 2105},
     {"name": "jjj", "size": 1316},
     {"name": "jjj", "size": 3151},
    ]
   },
   {
    "name": "Утримування, обслуговування та поточний ремонт інженерних мереж",
    "children": [
     {"name": "jjj", "size": 8258},
     {"name": "jjj", "size": 10001},
     {"name": "jjj", "size": 8217},
     {"name": "jjj", "size": 12555},
    ]
   },
   {
    "name": "Заходи з брендування території ",
    "children": [
      {"name": "jjj", "size": 1302},
      {"name": "jjj", "size": 24593},
    ]
   }
  ]
 }
];

var margin = {
  top: 90,
  right: 500,
  bottom: 80,
  left: 430
},
width = 900 - margin.right - margin.left,
height = 360 - margin.top - margin.bottom;

var i = 0,
duration = 750,
rectW = 180,
rectH = 50;

var tree = d3.layout.tree().nodeSize([height, width]);

var diagonal = d3.svg.diagonal()
.projection(function(d) {
  return [d.x, d.y];
});

var accountSvg = d3.select(".tree").append("svg")
.attr("width", 1000)
.attr("height", 1000)
.append("g")
.attr("transform", "translate(" + margin.left + "," + margin.left + ")");


root = treeData[0];
root.x0 = height / 2;
root.y0 = 0;

function collapse(d) {
  if (d.children) {
    d._children = d.children;
    d._children.forEach(collapse);
    d.children = null;
  }
}

root.children.forEach(collapse);
update(root);

d3.select(".tree").style("455", "weight");

function update(source) {

// Compute the new tree layout.
var nodes = tree.nodes(root).reverse(),
  links = tree.links(nodes);

// Normalize for fixed-depth.
nodes.forEach(function(d) {
  d.y = d.depth * 180;
});

// Update the nodes…
var node = accountSvg.selectAll("g.node")
  .data(nodes, function(d) {
    return d.id || (d.id = ++i);
  });

// Enter any new nodes at the parent's previous position.
var nodeEnter = node.enter().append("g")
  .attr("class", "node")
  .attr("transform", function(d) {
    return "translate(" + source.x0 + "," + source.y0 + ")";
  })
  .on("click", click);

nodeEnter.append("rect")
  .attr("width", rectW)
  .attr("height", rectH)
  .attr("stroke", "black")
  .attr("stroke-width", 1)
  .style("fill", function(d) {
    return d._children ? "lightsteelblue" : "#fff";
  });

nodeEnter.append("text")
  .attr("x", rectW / 2)
  .attr("y", rectH / 2)
  .attr("dy", ".35em")
  .attr("text-anchor", "middle")
  .text(function(d) {
    return d.name;
  })
  .each(function(d) {
    calculateTextWrap(this,d);
 });

// Transition nodes to their new position.
var nodeUpdate = node.transition()
  .duration(duration)
  .attr("transform", function(d) {
    return "translate(" + d.x + "," + d.y + ")";
  });

nodeUpdate.select("rect")
  .attr("width", rectW)
  .attr("height", rectH)
  .attr("stroke", "black")
  .attr("stroke-width", 1)
  .style("fill", function(d) {
    return d._children ? "lightsteelblue" : "#fff";
  });

nodeUpdate.select("text")
  .style("fill-opacity", 1)
  .style("fill", 'black');

  

// Transition exiting nodes to the parent's new position.
var nodeExit = node.exit().transition()
  .duration(duration)
  .attr("transform", function(d) {
    return "translate(" + source.x + "," + source.y + ")";
  })
  .remove();

nodeExit.select("rect")
  .attr("width", rectW)
  .attr("height", rectH)
  .attr("stroke", "black")
  .attr("stroke-width", 1);

nodeExit.select("text");

function calculateTextWrap(element, data) {
  var text = d3.select(element);
  if (text.node().getComputedTextLength() < 170) {
      //console.log("No need to wrap");
  } else {
      var words = text.text().split("").reverse(),
          word,
          line = [],
          lineNumber = 0,
          lineHeight = 1.1, // ems
          y = text.attr("y"),
          dy = parseFloat(0.65),
          tspan = text.text(null).append("tspan").attr("text-anchor", "start").attr("x", 10).attr("y", y).attr("dy", dy + "em");

      while (word = words.pop()) {
          line.push(word);
          tspan.text(line.join(""));
          if (tspan.node().getComputedTextLength() > 170) {
              lineNumber++;
              line.pop();
              tspan.text(line.join(""));
              line = [word];
              tspan = text.append("tspan").attr("text-anchor", "start").attr("x", 10).attr("y", y).attr("dy", lineHeight + dy + "em").text(word);
          }
      }
  }
var rectHeight = text.node().getBBox().height;
if(rectHeight < 30) rectHeight = 30;
data.rectHeight = rectHeight + 10 ;
}

// Update the links…
var link = accountSvg.selectAll("path.link")
  .data(links, function(d) {
    return d.target.id;
  });

// Enter any new links at the parent's previous position.
link.enter().insert("path", "g")
  .attr("class", "link")
  //.attr("transform", function (d) {
  //    return "translate(" + rectW + "," + rectH / 2 + ")";
  //})
  .attr("d", function(d) {
    var o = {
      x: source.x0,
      y: source.y0
    };
    return diagonal({
      source: o,
      target: o
    });
  });

// Transition links to their new position.
link.transition()
  .duration(duration)
  .attr("d", function(d) {
    var s = {
      y: d.source.y + rectW / 4,
      x: d.source.x + rectW / 2
    };
    var t = {
      x: d.target.x + rectW / 2, 
      y: d.target.y
    };
    return diagonal({
      source: s,
      target: t
    })
  });
//.attr("d", diagonal);

// Transition exiting nodes to the parent's new position.
link.exit().transition()
  .duration(duration)
  .attr("d", function(d) {
    var o = {
      x: source.x,
      y: source.y
    };
    return diagonal({
      source: o,
      target: o
    });
  })
  .remove();

// Stash the old positions for transition.
nodes.forEach(function(d) {
  d.x0 = d.x;
  d.y0 = d.y;
});
}

var doubleClickTime = 0;
var threshold = 200;
// Toggle children on click.
function click(d) {
var t0 = new Date();
if (t0 - doubleClickTime > threshold) {
  setTimeout(function() {
    if (t0 - doubleClickTime > threshold) {

      if (d.children) {
        d._children = d.children;
        d.children = null;
      } else {
        d.children = d._children;
        d._children = null;
      }
      update(d);

    }
  }, threshold);
}
}

// Redraw for zoom
function redraw() {
//console.log("here", d3.event.translate, d3.event.scale);
accountSvg.attr("transform",
  "translate(" + d3.event.translate + ")" + " scale(" + d3.event.scale + ")");
}

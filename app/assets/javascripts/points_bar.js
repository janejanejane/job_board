$('document').ready(function(){
	console.log("barchart...");
	console.log(data);
	console.log(total);

  var svg = d3.select(".chart").append("svg")
    .attr("class", "chart")
    .attr("width", 500)
    .attr("height", 140)
  .append("g")
    .attr("transform", "translate(150,15)");

	var x = d3.scale.linear()
	    .domain([0, d3.max(data, function(d){
        return Math.round(d.points/10) * 10; // round to nearest 10th
      })])
	    .range([0, 420]);

  var y = d3.scale.ordinal()
    .domain(data.map(function (d){ return d.name;})) // create range from array of objects
    .rangeBands([0, 120]);

  svg.selectAll("rect")
    .data(data)
  .enter().append("rect")
    .attr("class", function(d){ 
      var name = d.name.replace(/\s/g, ""); // trim inner spaces
      name = name.toLowerCase(); // change to lower case
      return name;
    })
    .attr("y", function(d,i){
      return y(i);
    })
    .attr("width", function(d,i){ 
      return x(d.points); 
    })
    .attr("height", y.rangeBand());

  svg.selectAll(".bar")
    .data(data)
  .enter().append("text")
    .attr("class", "bar")
    .attr("x", function(d,i){
      return  x(d.points);
    })
    .attr("y", function(d,i) { return y(i) + y.rangeBand() / 2; })
    .attr("dx", -3) // padding-right
    .attr("dy", ".35em") // vertical-align: middle
    .attr("text-anchor", "end") // text-align: right
    .text(function(d,i){ return d.points; });

  svg.selectAll(".label")
    .data(data)
  .enter().append("text")
    .attr("class", "label")
    .attr("x", -10)
    .attr("y", function(d,i) { return y(i) + y.rangeBand() / 2; })
    .attr("dx", -3) // padding-right
    .attr("dy", ".35em") // vertical-align: middle
    .attr("text-anchor", "end") // text-align: right
    .text(function(d,i){ 
      var jobpref = d.name;
      if(d.preferred){
        jobpref += " (preferred)";
      }

      return jobpref; 
    });
  // svg.selectAll("line")
  //   .data(x.ticks(10))
  // .enter().append("line")
  //   .attr("x1", x)
  //   .attr("x2", x)
  //   .attr("y1", 0)
  //   .attr("y2", 120)
    // .style("stroke", "#ccc");

  // svg.selectAll(".rule")
  //   .data(x.ticks(10))
  // .enter().append("text")
  //   .attr("class", "rule")
  //   .attr("x", x)
  //   .attr("y", 0)
  //   .attr("dy", -3)
  //   .attr("text-anchor", "middle")
  //   .text(String);

  svg.append("line")
    .attr("y1", 0)
    .attr("y2", 120)
    .style("stroke", "#000");


});
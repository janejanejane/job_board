$('document').ready(function(){
	console.log("barchart...");
	console.log(data);
	console.log(total);

  var div = d3.select(".chartContainer").append("div")
    .attr("class", "chart")
    .style("position", "relative")
    .attr("width", 500)
    .attr("height", 140);

	var x = d3.scale.linear()
	    .domain([0, d3.max(data, function(d){
        return Math.round(d.points/10) * 10; // round to nearest 10th
      })])
	    .range([0, 420]);

  var y = d3.scale.ordinal()
    .domain(data.map(function (d){ return d.name;})) // create range from array of objects
    .rangeBands([0, 120]);

  var bar = div.selectAll(".bar-container")
    .data(data)
  .enter().append("div")
    .attr("class", function(d){ 
      var name = d.name.replace(/\s/g, ""); // trim inner spaces
      name = name.toLowerCase(); // change to lower case
      return name + " bar-container";
    })
    .style("top", function(d,i){ return y(i) + "px"})
    .style("position", "absolute")
    .style("height", y.rangeBand() + "px");

  
  bar.append("div")
    .attr("class", "label")
    .style("width", "-10px")
    //.style("top", function(d,i){ return y(i) + "px"})
    .text(function(d,i){ 
      var jobpref = d.name;
      if(d.preferred){
        jobpref += " (preferred)";
      }

      return jobpref; 
    });

  bar.append("div")
    .attr("class", "bar-color")
    .style("width", function(d,i){ 
      return x(d.points) + "px"; 
    })
    .text(function(d,i){ return d.points; });

  bar.append("div")
    .attr("class", "voters")
    .html(function(d,i){
      return d.voters;
    })
});
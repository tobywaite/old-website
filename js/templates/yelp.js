// Generated by CoffeeScript 1.3.3
(function() {

  this.templates.yelp = "<!--\n{\n  \"biz-name\":\n  \"biz-uri\":\n  \"location\":\n  \"date\":\n  \"time\":\n  \"tip\":\n}\n-->\n\n<h2>\n  yelp\n  <small><a href='http://twaite.yelp.com/'>twaite</a></small>\n</h2>\n<div class=\"row\">\n  <div class='span1'>\n    <img class='logo' src='img/yelp.png' alt=\"yelpers gonna yelp\">\n  </div>\n  <div class='span4'>\n    <h3>\n      {{biz-name}}\n      <small><a href='{{biz-uri}}'>Latest Check-in</a></small>\n    </h3>\n    <p>{{location}}<small>{{date}}@{{time}}</small></p>\n    {{#tip}}\n    <blockquote>\n      {{tip}}\n    </blockquote>\n    {{/tip}}\n  </div>\n</div>";

}).call(this);
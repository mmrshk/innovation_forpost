(function ($) {
  "use strict";
  $.fn.responsiveTable = function() { 

    let toggleColumns = function($table) {
      let selectedControls = [];
      $table.find(".accordion").each( function() {
        selectedControls.push( $(this).attr("aria-selected") );
      });
      let cellCount = 0, colCount = 0;
      let setNum = $table.find(".cell").length / $table.find(".accordion").length;
      $table.find(".cell").each( function() {
        $(this).addClass("hidden-small");
        if( selectedControls[colCount] === "true" ) $(this).removeClass("hidden-small");
        cellCount++;
        if( cellCount % setNum === 0 ) colCount++; 
      });
    };
    $(this).each(function(){ toggleColumns($(this)); });
    $(this).find(".accordion").on("click", function() {
      $(this).attr("aria-selected", $(this).attr("aria-selected") !== "true" );
      toggleColumns( $(this).parents(".row-table") );
    });

  };
}(jQuery));

$(".js-table-accordions").responsiveTable();

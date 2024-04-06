import $ from "jquery";

$(document).on("turbo:load", function () {
  $("#showOverlay").on("click", function () {
    $("#overlay").css("display", "flex");
  });

  $("#closeOverlay").on("click", function () {
    $("#overlay").css("display", "none");
  });
});

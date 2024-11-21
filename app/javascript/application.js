// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function toggleGames() {
  var moreGames = document.getElementById("more-games");
  var toggleButton = document.getElementById("toggle-games-btn");

  if (moreGames.style.display === "none") {
    // Show more games
    moreGames.style.display = "block";
    toggleButton.textContent = "Show Less"; 
  } else {
    // Hide more games
    moreGames.style.display = "none";
    toggleButton.textContent = "Show More"; 
  }
}

import socket from "./socket"

function Place(channel){
  this.colors = ['#000000', '#9C9C9C', '#FFFFFF', '#BE2734', '#E16E8B', '#493C2B', '#A46527', '#EA892E', '#F7E26B', '#31484D', '#458A40', '#A2CD3A', '#1B2632', '#005885', '#4C9DD6', '#B3DCEE'];

  this.grid = {
    width: 100,
    height: 100
  }

  this.pixel = {
    width: 16,
    height: 16
  }

  this.canvas = document.getElementById("place-canvas");

  this.canvas.addEventListener("click", this.onclick.bind(this));
  this.context = this.canvas.getContext("2d");

  this.channel = socket.channel("place:board", {})
  this.channel.join()
    .receive("ok", resp => { this.getBoard() } )
    .receive("error", resp => { console.log("Unable to join", resp) })

  this.channel.on("pixel", payload => {
    this.drawPixel(payload.pixel);
  });

}

Place.prototype = {
  getBoard: function(){
    this.channel.push("get_board")
      .receive("ok", resp => { this.drawBoard(resp.board)})
      .receive("error", resp => { console.log("error", resp) })
  },
  drawBoard: function(board){
    for (var i in board){
      this.drawPixel({x: i % this.grid.width, y: Math.floor(i / this.grid.width), color: board[i]});
    };
  },
  drawPixel: function(pixel){
    this.context.fillStyle = this.colors[pixel.color];

    this.context.fillRect(
      pixel.x * this.pixel.width,
      pixel.y * this.pixel.height,
      this.pixel.width,
      this.pixel.height);
  },
  onclick: function(event){
    var location = {
      x: event.offsetX / this.pixel.width,
      y: event.offsetY / this.pixel.height
    };
    this.updatePixel({x: Math.floor(location.x), y: Math.floor(location.y), color: 0});
  },
  updatePixel: function(pixel){
    this.channel.push("update_pixel", {pixel: pixel});
  },
  clearBoard: function(){
    this.channel.push("clear_board")
      .receive("ok", resp => { this.getBoard(); });
  },
  clearHistory: function(){
    this.channel.push("clear_history")
      .receive("ok", resp => { this.getBoard(); });
  }
}

document.place = new Place();

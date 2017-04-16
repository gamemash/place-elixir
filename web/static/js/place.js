import socket from "./socket"

function Place(channel){
  this.colors = ['#000000', '#9C9C9C', '#FFFFFF', '#BE2734', '#E16E8B', '#493C2B', '#A46527', '#EA892E', '#F7E26B', '#31484D', '#458A40', '#A2CD3A', '#1B2632', '#005885', '#4C9DD6', '#B3DCEE'];
  this.width = 10;
  this.height = 10;

  this.canvas = document.getElementById("place-canvas");

  this.canvas.addEventListener("click", this.onclick);
  this.context = this.canvas.getContext("2d");

  this.channel = socket.channel("place:board", {})
  this.channel.join()
    .receive("ok", resp => { this.getBoard() } )
    .receive("error", resp => { console.log("Unable to join", resp) })

}

Place.prototype = {
  getBoard: function(){
    this.channel.push("get_board")
      .receive("ok", resp => { this.updateBoard(resp.board)})
      .receive("error", resp => { console.log("error", resp) })
  },
  updateBoard: function(board){
    console.log("Got board", board);
    for (var i in board){
      this.drawPixel({x: i % this.width, y: Math.floor(i / this.width), color: board[i]});
    };
  },
  drawPixel: function(pixel){
    var width   = 32;
    var height  = 32;
    this.context.fillStyle = this.colors[pixel.color];
    this.context.fillRect(
      pixel.x * width,
      pixel.y * height,
      (pixel.x + 1) * width,
      (pixel.y + 1) * height);
  },
  onclick: function(event){
    console.log(event.offsetX, event.offsetY);
  }
}



document.place = new Place();

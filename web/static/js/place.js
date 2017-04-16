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
  this.addButtons();

  this.channel = socket.channel("place:board", {})
  this.channel.join()
    .receive("ok", resp => { this.getBoard() } )
    .receive("error", resp => { console.log("Unable to join", resp) })

  this.channel.on("pixel", payload => {
    this.drawPixel(payload.pixel);
  });

  this.currentColor = 0;
}

Place.prototype = {
  addButtons: function(){
    var container = document.getElementById("color-picker-container");
    var i;
    for (i in this.colors){
      (function(i) {
        var btn = document.createElement("button");
        btn.className = "color-btn btn";
        btn.style = "background-color: " + this.colors[i] + ";";
        btn.onclick = function(){ var color = i; this.setColor(color); }.bind(this);
        container.appendChild(btn);
      }).bind(this)(i);
    }

    //<button class="color-btn btn" onclick="place.currentColor = <%=i%>"></button>
  },
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
      x: Math.floor(event.offsetX / this.pixel.width),
      y: Math.floor(event.offsetY / this.pixel.height)
    };
    this.updatePixel({x: location.x, y: location.y, color: this.currentColor});
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
  },
  setColor: function(color){
    this.currentColor = color;
  }
}

document.place = new Place();

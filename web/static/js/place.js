import socket from "./socket"

function Place(channel){
  this.channel = socket.channel("place:board", {})
  this.channel.join()
    .receive("ok", resp => { this.getBoard() } )
    .receive("error", resp => { console.log("Unable to join", resp) })

}

Place.prototype = {
  getBoard: function(){
    this.channel.push("get_board")
      .receive("ok", resp => { this.updateBoard(resp)})
      .receive("error", resp => { console.log("error", resp) })
  },
  updateBoard: function(board){
    console.log("Got board", board);
  }
  
}



document.place = new Place();

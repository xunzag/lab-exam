import React, { Component } from 'react'
import url from './Variable'

export default class TimeSlot extends Component {
  constructor(props){
    super(props)
    this.state={
      timeslots:[],
      Rooms:[],
      TSId:0,
      TSCode:"",
      StartTime:"",
      EndTIme:"",
      RId:0
    }
  }

  getTimeSlot(){
    fetch(url.baseurl+"TimeSlot")
    .then(res => res.json())
    .then((data)=>{
        this.setState({
          timeslots:data
        })
    })
  }

  getRooms(){
    fetch(url.baseurl+"Room")
    .then(res => res.json())
    .then((data)=>{
        this.setState({
          Rooms:data
        })
    })
  }

  createTimeSlot(){
    fetch(url.baseurl+"TimeSlot",{
      method:"POST",
      headers:{
        "Accept":"application/json",
        "Content-Type":"application/json"
      },
      body:JSON.stringify({
      TSCode:this.state.TSCode,
      StartTime:this.state.StartTime,
      EndTIme:this.state.EndTIme,
      RId:this.state.RId
      })
    }).then(res =>{
      alert("Data Added Ustat")
      this.getTimeSlot()
      this.getRooms()
    }).catch((err)=>{
      alert("Error",err)
    })
  }

  updateTimeSlot(){
    fetch(url.baseurl+"TimeSlot",{
      method:"PUT",
      headers:{
        "Accept":"application/json",
        "Content-Type":"application/json"
      },
      body:JSON.stringify({
        TSId:this.state.TSId,
      TSCode:this.state.TSCode,
      StartTime:this.state.StartTime,
      EndTIme:this.state.EndTIme,
      RId:this.state.RId
      })
    }).then(res =>{
      alert("Data Updated Ustat")
      this.getTimeSlot()
      this.getRooms()
    }).catch((err)=>{
      alert("Error",err)
    })
  }

  delTimeSlot(id){
    fetch(url.baseurl+"TimeSlot",{
      method:"DELETE",
      headers:{
        "Accept":"application/json",
        "Content-Type":"application/json"
      },
      body:JSON.stringify({
        TSId:id
      })
    }).then(res =>{
      alert("Data Shaat Ustat")
      this.getTimeSlot()
      this.getRooms()
    }).catch((err)=>{
      alert("Error",err)
    })
  }

  componentDidMount(){
    this.getTimeSlot();
    this.getRooms();
  }
  
  render() {
    const {timeslots,Rooms,TSId,TSCode,StartTime,EndTIme,RId} = this.state
    return (
      <div>
        <div className="container my-5">
          <button className="btn btn-primary" data-bs-toggle="modal" onClick={()=>{
                      this.setState({
                        TSId:0,
                        TSCode:"",
                        StartTime:"",
                        EndTIme:"",
                        RId:0
                      })
                    }} data-bs-target="#exampleModal">Add Time Slot</button>
          <table class="table">
            <thead>
              <tr>
                <th scope="col">TSId</th>
                <th scope="col">TSCode</th>
                <th scope="col">Start Time</th>
                <th scope="col">End Time</th>
                <th scope="col">Room Name</th>
                <th scope="col">Actions</th>

              </tr>
            </thead>
            <tbody>
             {
              timeslots.map((t)=>{
                return(
                  <tr>
                    <td>{t.TSId}</td>
                    <td>{t.TSCode}</td>
                    <td>{t.StartTime}</td>
                    <td>{t.EndTIme}</td>
                    <td>{t.RName}</td>
                    <td>
                    <button className="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" onClick={()=>{
                      this.setState({
                        TSId:t.TSId,
                      TSCode:t.TSCode,
                      StartTime:t.StartTime,
                      EndTIme:t.EndTIme,
                      RId:t.RId
                      })
                    }} >Edit</button> | <button className="btn btn-sm btn-danger" onClick={()=>{this.delTimeSlot(t.TSId)}}>Delete</button>
                    </td>
                  </tr>
                )
              })
             } 

              
            </tbody>
          </table>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Add TimeSlot</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <form>
                  <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">TSCode</label>
                    <input type="text" class="form-control" value={TSCode} onChange={(e)=>{this.setState({TSCode:e.target.value})}}  id="exampleInputEmail1" aria-describedby="emailHelp" />
                  </div>
                  <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Start Time</label>
                    <input type="text" class="form-control" value={StartTime} onChange={(e)=>{this.setState({StartTime:e.target.value})}} id="exampleInputPassword1" />
                  </div>
                  <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">End Time</label>
                    <input type="text" class="form-control" value={EndTIme} onChange={(e)=>{this.setState({EndTIme:e.target.value})}} id="exampleInputPassword1" />
                  </div>
                  <div class="mb-3">
                    <select class="form-select" value={RId} select onChange={(e)=>{this.setState({RId:e.target.value})}} aria-label="Default select example">
                      <option selected>Select Room</option>
                      {
                        Rooms.map((r)=>{
                          return(
                            <option value={r.RId}>{r.RId}</option>
                            
                          )
                        })
                      }
                    </select>
                  </div>

                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                {
                  TSId===0? <button type="button" class="btn btn-primary" onClick={()=>{this.createTimeSlot()}} data-bs-dismiss="modal">Save changes</button>:
                  <button type="button" class="btn btn-primary" onClick={()=>{this.updateTimeSlot()}} data-bs-dismiss="modal">Update Changes</button>
                }
                
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

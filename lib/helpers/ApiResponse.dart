class ApiResponse {
   String status;
   String requestId;
   Map result;
  ApiResponse(response){
    this.status = response.data["status"];
    this.requestId = response.data["requestId"];
    this.result = response.data["result"];

  }
}
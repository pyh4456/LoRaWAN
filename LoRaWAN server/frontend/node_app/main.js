var http = require('http');
var fs = require('fs');
var url = require('url');
const qs = require('querystring');
const dayjs = require('dayjs');

var server = http.createServer(function handler(req,res) {  
  var parsedURL = url.parse(req.url);
  var resource = parsedURL.pathname;
  var qry = parsedURL.query;

  const mysql = require('mysql');  // mysql 모듈 로드
  const conn = {  // mysql 접속 설정
    host: 'database',
    port: '3306',
    user: 'root',
    password: '1234',
    database: 'lorawan'
  };

  const date = dayjs();

  if(resource == '/app'){
    res.writeHead(200, {'Content-Type' : 'JSON'});
    console.log(date.format());
    let connection = mysql.createConnection(conn); // DB 커넥션 생성
    connection.connect();   // DB 접속
 
    if(qry == 0){
      sql = "SELECT * FROM lorawan.parking_lot";
    }
    else{
      sql = "SELECT * FROM lorawan.parking_lot where building_number="+qry;
    }

    connection.query(sql, function (err, results, fields) { 
      if (err) {
        console.log(err);
        setTimeout(handleDisconnect, 2000); 
      }
      console.log("app request : " + qry);
      connection.end();
      res.end(JSON.stringify(results, null, 2));
    });
  }
  else if(resource == '/chirpstack'){
    let connection = mysql.createConnection(conn); // DB 커넥션 생성
    connection.connect();   // DB 접속
 
    console.log(date.format());
    req.setEncoding('utf-8');
    
    var postdata = '';
    req.on('data',function(data){
      postdata = postdata + data;
    });

    req.on('end', function () {
      datajson = JSON.parse(postdata).objectJSON;
      data = JSON.parse(datajson).mydata*1;
      deviceAddress = JSON.parse(postdata).devAddr;
      console.log('data : '+data);

      buffer = Buffer.from(deviceAddress, 'base64');
      bufString = buffer.toString('hex');

      building_number = bufString.substring(0,4)*1;
      parking_lot_number = bufString.substring(4)*1;

      console.log('building number : '+ building_number);
      console.log('parking_lot_number : '+ parking_lot_number);

      let sql = "UPDATE lorawan.parking_lot SET occupied = "+ data +" WHERE building_number = "
      + building_number + " AND parking_lot_number = " + parking_lot_number +";";
  
      connection.query(sql, function (err, results, fields) { 
        if (err) {
          console.log(err);
        }
      });
      
      connection.end();
    });
    
  }

}).listen(3000);


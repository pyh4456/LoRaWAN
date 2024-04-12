# Capstone-2022-1-30


### 1. 프로젝트 소개
주제: 오픈 소스 (Open Source)를 활용한 교내 (PNU) LoRaWAN 네트워크 망 구축 및 운용\
LoRaWAN을 사용한 부산대 옥외 주차장 모니터링 시스템을 구축했다.
### 2. 팀소개
박윤형, the4456@pusan.ac.kr, 서버 구축 및 개발 총괄\
오세영, seiyoung0@gmail.com, 임베디드 시스템 및 어플리케이션 개발
### 3. 시스템 구성도
본 프로젝트는 크게 세 부분으로 나누어 진다.\
초음파 센서를 사용하고 LoRa통신을 하기 위한 임베디드 디바이스,\
도커를 통해 구축한 서버, 안드로이드 어플리케이션

전체적인 구성은 아래의 그림과 같다.
![Untitled Diagram drawio](https://user-images.githubusercontent.com/62279820/195645524-118db5f7-8c19-4c05-a1ec-c6dd0bf61f2f.png)

#### 3.1. 임베디드 디바이스
![parkinglot drawio (1)](https://user-images.githubusercontent.com/62279820/195645197-9030cc7d-653b-4774-b808-c67b95f1df67.png)\
디바이스에는 초음파센서를 연결해 사용하고 있으며,\
임베디드 보드는 LoRa통신을 위해 만들어진 것을 사용한다.
#### 3.2. 서버
![docker container drawio](https://user-images.githubusercontent.com/62279820/195646292-6afd2c37-055e-4f37-bc82-06a9a4b2470a.png)\
위의 그림에서 네모칸들은 네트워크를 구성하는 엔티티이다.\
Docker 내부에 있는 네모는 모두 Docker 컨테이너이며 네모 안의 숫자는\
사용하는 포트로서 "(외부포트) -> (내부포트)"의 형태로 나타냈다.
#### 3.3. 어플리케이션
![캡처](https://user-images.githubusercontent.com/62279820/195648177-6697feda-55ec-4341-ba8e-2ef27edc5fdf.PNG)
![캡처2](https://user-images.githubusercontent.com/62279820/195648184-9e4bb3f9-c53a-4834-a021-cc1a176e2435.PNG)\
어플리케이션의 동작 화면은 위와 같다.\
왼쪽 화면의 동그란 아이콘을 터치하면 오른쪽의 화면이 나오도록 구현했다.
### 4. 시연 영상
https://github.com/PNUCSE/Capstone-2022-1-30/assets/62279820/938ece35-9417-4b81-a026-f2b2be1174bf


### 5. 설치 및 사용법

프로젝트를 설치하기 위해 먼저 git과 Docker를 사용할 수 있는 환경이어야 한다.\
git과 Docker를 설치했으면 원하는 디렉토리에서 아래의 명령어로 github의 repository를 복사한다.
```
git clone https://github.com/ParkYoonHyeong/Capstone-2022-1-30.git
```
#### 5.1. 서버
##### 서버 배포
 repository 복사가 완료되면 폴더 내의 'LoRaWAN server'폴더로 이동한다.\
 그후 아래의 명령어로 docker container를 만들 수 있다.
```
docker-compose up 
```
docker container가 모두 만들어 지면 ChirpStack, MySQL은 그대로 사용이 가능하다.\
웹서버는 따로 실행을 해줄 필요가 있다. 이를 위해 다음의 명령어를 실행해서 웹서버를 배포하고\
해당 터미널에서 웹서버의 로그를 확인할 수 있다.
```
docker exec -it lorawanserver_node_app_1 bash
node main.js
```
##### ChirpStack 설정
서버의 데이터를 저장해서 github에 올리고 싶었지만 저장된 위치를\
찾지 못했기 때문에 ChirpStack의 설정은 직접 해야 한다.\
세세한 설정은 ChirpStack의 동작이지 본 프로젝트에서 구현한 부분이 아니기 때문에 설명하지 않겠다.\
본 프로젝트에서 고정적으로 사용해야 하는 부분을 아래에 설명해 놓았다.

우선 네트워크 서버의 프로필을 만들때 서버 주소를 아래의 주소로 입력한다.
```
chirpstack-network-server:8000
```
그 후 device profile을 만들어야 한다. 아래의 스크린샷을 참고하라.
![image](https://user-images.githubusercontent.com/62279820/195658540-715315d0-137a-43a7-b7db-c4fc7200ebce.png)
이때 codec을 설정해야 하는데, 'Custom JavaScript codec functions'을 사용하며 디코더로 아래의 내용을 입력한다.
```
function toHexString(bytes){
  return bytes.map(function(byte){
    return ("00" + (byte & 0xFF).toString(16)).slice(-2)
  }).join('')
}

function Decode(fPort, bytes){
  var toHex = toHexString(bytes);
  return {"mydata":toHex};
}
```
마지막으로 application을 생성해 integration을 설정해야 한다.\
integration은 HTTP를 선택한다.\
Payload marshaler은 JSON을 선택하고, Endpoint로 웹서버의 주소인 아래의 주소를 입력한다
```
http://host.docker.internal:3030/chirpstack
```
이외에 gateway와 end node를 연동하기 위한 과정은 굳이 설명하지 않겠다.

#### 5.2. 임베디드 보드 펌웨어
end node에 펌웨어를 올리기 위해 STM32CubeIDE를 사용한다.\
stIDEProject 폴더 내의 프로젝트를 그대로 사용하면 된다.\
다만, 펌웨어를 올리기 전에 서버에서 사용하는 app session key와\
network session key를 동일하게 lora_app.h에 작성해야 한다.\
gateway를 ChirpStack에 연결할때 ChirpStack의 gateway bridge의 주소를 입력해야 한다.\
아래의 형태로 된 주소를 입력해야 한다.
```
(사용하는 도메인):1700
```
#### 5.3. 어플리케이션 빌드
Android application 폴더 내의 프로젝트를 android studio에서 import 해서 사용한다.\
빌드 하기 전에 웹서버의 주소를 바꿔주어야 한다.
```
Android application\app\src\main\java\android\cs\pusan\ac\parking_lot_app
```
위의 위치에 있는 모든 java파일에서 웹서버의 도메인을 사용하고 있는 도메인으로 바꿔야 한다.
![image](https://user-images.githubusercontent.com/62279820/195663154-a4f09331-08f8-41e0-a4d2-27d107d3d5bc.png)\
위의 사진에서 'http://the4456.iptime.org'를 사용하고 있는\
도메인으로 모두 바꿔주고 빌드하면 어플리케이션의 연동이 완료된다.

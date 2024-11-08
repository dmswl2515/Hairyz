# 털뭉치즈(Hairyz)
[1. 개요](#1개요)<br>
[2. 사용언어 및 개발환경](#2-사용언어-및-개발환경)<br>
[3. 시스템 아키텍처](#3-시스템-아키텍처)<br>
[4. 기능 소개](#4-기능-소개)<br>
[5. TROUBLESHOOTING](#5-troubleshooting)<br>
[6. 느낀점](#6-느낀점)


## 1.개요
| `목록`            | `내용`                                                                                                          |
|     :---:        | ---------------------------------------------------------------------------------------------------------------|
| `작업기간`         | `4 주`                                                                              |
| `참여인원`         | `3명`                                                                                                           |
| `프로젝트 목적`     | `반려인들에게 반려동물을 위한 쇼핑, 정보 공유, 동물병원 및 카페 검색이 가능한 통합 플랫폼을 제공`                                     |
| `주요업무`         | `- 쇼핑 페이지 전반 구현` <br> `- 관리자 페이지 중 상품 관리, 커뮤니티 관리 담당` <br> `- 통합검색 기능 구현` <br> `- SNS 로그인, 아이디/비밀번호 찾기, 결제, 지도, 1:1 문의 기능을 위한 API 연동`<br> `- 유기동물 현황 공공 데이터 통계 분석 및 시각화`                                                                                                  | 


## 2. 사용언어 및 개발환경
- Java, Sql, Spring Boot, Docker, Github

## 3. 시스템 아키텍처
<img src="https://github.com/user-attachments/assets/f091be3a-7e9a-41e5-9f88-094cfafe23f7" width="650" height="450"/><br>
털뭉치즈는 WS EC2 환경에서 Spring Boot 애플리케이션과 Oracle 데이터베이스를 활용하여 구성된 웹 애플리케이션입니다.<br>
외부 통합 서버와 데이터베이스 서버는 Amazon Linux 2 기반 EC2 인스턴스에서 운영되며, 사용자는 브라우저를 통해 API 컨트롤러, 서비스, 리포지토리, 엔티티 계층을 거쳐 데이터에 접근합니다.<br>
Oracle SQL Developer를 통해 데이터베이스 관리 및 모니터링이 가능합니다.

## 4. 기능 소개

#### 아이디/비밀번호 찾기
<img src="https://github.com/user-attachments/assets/a67cb852-07aa-464c-8118-40c42a2e0ed9" width="650" height="450"/>

#### SNS 로그인
<img src="https://github.com/user-attachments/assets/834cdbd2-6cc4-4105-b2b3-132b6f73df70" width="650" height="450"/>

#### 쇼핑 > 메인화면
<img src="https://github.com/user-attachments/assets/266661ca-f304-43b2-a317-d89cfa15cfc7" width="650" height="450"/>

#### 쇼핑 > 상세페이지
<img src="https://github.com/user-attachments/assets/09976dff-a26e-4df1-816f-c89ff0b6fb11" width="650" height="450"/>

#### 쇼핑 > 결제페이지
<img src="https://github.com/user-attachments/assets/6ba34eff-dd6f-47f8-9697-dda8b8a83ba9" width="650" height="450"/>

#### 쇼핑 > 장바구니
<img src="https://github.com/user-attachments/assets/acfef7d5-d267-4288-843f-61df492a0b31" width="650" height="450"/>

#### 지도(동물병원 및 애견카페)
<img src="https://github.com/user-attachments/assets/01aab33a-9e8c-49dd-b5ca-8c66115955be" width="650" height="450"/>

#### 유기동물 현황
<img src="https://github.com/user-attachments/assets/9ddcdefc-420b-4712-97f9-6a3a04e634c6" width="650" height="450"/>

#### 관리자 > 상품관리
<img src="https://github.com/user-attachments/assets/bddbbaa1-5117-4336-942f-3c09bcacf35a" width="650" height="450"/>

#### 1:1 문의
<img src="https://github.com/user-attachments/assets/91a02783-beb6-4a1c-b8a1-2aeb84f3e981" width="650" height="450"/>


## 5. TROUBLESHOOTING
<서버 배포 환경에서 발생한 문제 해결 경험><br>
로컬 환경에서 정상적으로 작동하던 기능들이 실제 서버에 배포되었을 때 예상치 못한 문제들이 발생했습니다.<br>
이 문제들을 해결하는 과정에서 많은 것을 배울 수 있었습니다. 주요 경험은 다음과 같습니다.

- 컨텍스트 루트 문제<br>
  로컬 환경에서는 정상적으로 작동하던 페이지 URL 이 서버 배포 후 제대로 연결되지 않는 문제가 발생했습니다.<br>
  이는 서버가 프로젝트의 컨텍스트 루트를 인식하지 못했기 때문으로, URL 앞에 `contextPath` 를 추가하여 문제를 해결했습니다.<br>
  이를 통해 배포 환경에 맞춰 URL 구조를 변경해야 할 필요성을 실감했고, 서버와 로컬 환경 간의 설정 차이로 인해 발생하는 문제 해결 방법을 학습했습니다.

- Geolocation API 사용 이슈<br>
  위치 정보 기반 기능 구현 시, 서버가 HTTP 로 운영되는 제약으로 인해 Geolocation API 가 작동하지 않아 사용자 위치를 불러오지 못하는 문제가 발생했습니다.<br>
  이를 통해 보안이 요구되는 브라우저 API 사용 시 HTTPS 환경의 중요성을 인식하게 되었으며, 추후 유사한 프로젝트에서는 보안 요구사항을 미리 고려하는 것이 중요하다는 것을 배웠습니다.


## 6. 느낀점
서버와 로컬 환경 간의 차이를 이해하고, 배포 환경에서 발생할 수 있는 문제들을 예측하고 해결하는 역량을 강화할 수 있었습니다.

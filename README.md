# Spot - 자전거사고 지점

>국내 자전거 사고 발생 지점을 검색해 지도에 표시해 주는 APP 서비스

<br>

<p align="center"><img src = "Image\appIcon.png" width = "200" ></p>

<p align="center">Spot - 자전거사고 지점</P>

<br>

<p align="center"><img src = "Image\appstore.png" width = "250" ></p>

<br>

- 나와 내 가족이 주로 이동하는 지역의 자전거 사고 발생 현황을 검색해 줍니다.
- 사고 발생 현황을 지도에 제공해 시각적으로 쉽게 확인할 수 있습니다. 
- **Data** : `도로교통공단`에서 제공하는 <u>자전거사고다발지역정보서비스</u> 자전거 교통사고 정보를 기반으로 정확한 정보를 제공합니다.

<br>

## 1. 개발 개요

- 개발 환경
  - 사용 Library : XMLParser, MapKit 
  - Design Architecture : MVVM Pattern
- **개발 기간** : 4일 (제작 3일, 배포준비 1일)

<br>

## 2. 주요 기능

<img src = "Image\image.png">

<br>

### 2-1. 편리한 검색 기능

- 검색하고자하는 지역을 **년도**와 **지역**으로 세분화해서 검색할 수 있습니다. 
- 사용자는 UISegment와 UIPickerView, UITableView를 통해 쉽게 선택 가능합니다. 

<img src = "Image\image1.png">

<br>

### 2-2. 세분화된 검색

- 검색 결과를 한번에 확인 가능하며, 총 발생한 사고 발생 건수도 제공
- 사고가 많은 지역의 경우 검색을 통해 빠르게 검색하게 검색 기능 포함

|            자전거사고 검색 화면            |                   검색 화면                    |
| :----------------------------------------: | :--------------------------------------------: |
| <img src = "Image\image2.png" width = 300> | <img src = "Image\searchList.gif" width = 260> |



<br>

### 2-3. 사고지역 정보 지도에 제공

- 모르는 지역에서도 쉽게 확인할 수 있도록 지도에 자전거 사고 지역을 표시

  <img src = "Image\image3.png" >




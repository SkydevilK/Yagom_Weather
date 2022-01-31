# Yagom_Weather

## 프로젝트 구조
- MVVM을 지향했다.
  - 첫 번째 화면에서 MVVM으로 데이터를 처리하였다.
  - 두 번째, 세 번째 화면은 비즈니스 로직이 거의 없기 때문에 ViewController에서 바로 데이터를 처리하였다.
  - API를 가져오는 부분은 따로 싱글톤패턴으로 처리하였다. (첫번째, 세번째 화면에서 사용하기 때문)

## 아쉬운 점
- MVVM을 제대로 하려면 DataBinding도 진행해야 하는데 시골을 가야해서 못했다.
- RxSwift / RxCocoa 등 Rx문법을 공부해야겠다.
- 그래프 그리는 부분에서 화씨로 변경할 경우 그래프가 지나치게 위로 올라가는 현상이 발생한다.
  - 아무래도 보정 값을 넣으면 될 것 같은데 아쉽다.


## 첫 번째 화면 (현재 날씨 화면에 표시)

- TableView를 활용해 도시들의 날씨를 보여주었다.

<img width="50%" src="https://user-images.githubusercontent.com/48668211/151744020-0afc81df-9432-412b-8a19-bbde36758aae.gif"/>

- 정렬 기능
  - 도시 이름 순 (오름차순)

<img width="50%" src="https://user-images.githubusercontent.com/48668211/151755434-40b269a7-13a0-4eb3-b80e-0bf394013429.mp4"/>

  - 현재 온도 순 (내림차순)

<img width="50%" src="https://user-images.githubusercontent.com/48668211/151755485-e4617f39-05be-4b26-ab2f-555c09c711e6.mp4"/>

- 섭씨 / 화씨 변경

<img width="50%" src="https://user-images.githubusercontent.com/48668211/151755715-d2ea3eef-3d8b-4752-a054-85c212d32db2.mp4"/>

## 두 번째 화면 (상세 화면 표시)

- 날씨 앱을 따라 만들어보려고 했으나 AutoLayout 부분이 익숙하지 않아 최고, 최저 온도가 약간 벌어져 있다.

<img width="50%" src="https://user-images.githubusercontent.com/48668211/151744534-04291168-213d-4827-94b8-0b15b6be7679.mp4"/>

## 세 번째 화면 (그래프 표시)

- 가로 축(시간)이 겹치는 이슈로 인해 40건의 데이터 중 5개만 가져와서 보여지도록 했다.
- 온도와 습도의 높이 차이가 있어서 습도의 50% == 온도의 0도 로 높이를 잡고 계산하였다.
- 가로 축(시간)의 TextView 위치를 맨 하단으로 설정하였다.

<img width="50%" src="https://user-images.githubusercontent.com/48668211/151744975-7194c5c2-7d3e-4213-8f6a-255c76372c4f.mp4"/>

## Localization

- 언어는 영어 / 한국어만 지원하도록 하였다.


<img width="50%" src="https://user-images.githubusercontent.com/48668211/151755814-a672fd97-a30b-42ac-9ef8-d869f296ad4a.mp4"/>

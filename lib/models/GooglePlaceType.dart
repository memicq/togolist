class GooglePlaceType {
  GooglePlaceTypeEnum type;
  int category;
  String code;
  String japaneseName;

  GooglePlaceType({
    this.type,
    this.category,
    this.code,
    this.japaneseName
  });
}

enum GooglePlaceTypeEnum {
  Accounting,
  Airport,
  AmusementPark,
  Aquarium,
  ArtGallery,
  Atm,
  Bakery,
  Bank,
  Bar,
  BeautySalon,
  BicycleStore,
  BookStore,
  BowlingAlley,
  BusStation,
  Cafe,
  Campground,
  CarDealer,
  CarRental,
  CarRepair,
  CarWash,
  Casino,
  Cemetery,
  Church,
  CityHall,
  ClothingStore,
  ConvenienceStore,
  CourtHouse,
  Dentist,
  DepartmentStore,
  Doctor,
  Drugstore,
  Electrician,
  ElectronicsStore,
  Embassy,
  FireStation,
  Flourist,
  FuneralHome,
  FurnitureStore,
  GasStation,
  Gym,
  HairCare,
  HardwareStore,
  HinduTemple,
  HomeGoodsStore,
  Hospital,
  InsuranceAgency,
  JewelryStore,
  Laundry,
  Lawyer,
  Library,
  LightRailStation,
  LiquorStore,
  LocalGovernmentStore,
  Locksmith,
  Lodging,
  MealDelivery,
  MealTakeaway,
  Mosque,
  MovieRental,
  MovieTheater,
  MovingCompany,
  Museum,
  NightClub,
  Painter,
  Park,
  Parking,
  PetStore,
  Pharmacy,
  Psysiotherapist,
  Plumber,
  Police,
  PostOffice,
  PrimarySchool,
  RealEstateAgency,
  Restaurant,
  RoofingContractor,
  RvPark,
  School,
  SecondarySchool,
  ShoeStore,
  ShoppingMall,
  Spa,
  Stadium,
  Storage,
  Store,
  SubwayStation,
  Supermarket,
  Synagogue,
  TaxiStand,
  TouristAttraction,
  TrainStation,
  TransitStation,
  TravelAgency,
  University,
  VeterinaryCare,
  Zoo,

  AdministrativeAreaLevel1,
  AdministrativeAreaLevel2,
  AdministrativeAreaLevel3,
  AdministrativeAreaLevel4,
  AdministrativeAreaLevel5,
  Archipelago,
  ColloquialArea,
  Continent,
  Country,
  Establishment,
  Finance,
  Floor,
  Food,
  GeneralContractor,
  Geocode,
  Health,
  Intersection,
  Landmark,
  Locality,
  NaturalFeature,
  Neighborhood,
  PlaceOfWorship,
  PlusCode,
  PointOfInterest,
  Political,
  PostBox,
  PostalCode,
  PostalCodePrefix,
  PostalCodeSuffix,
  PostalTown,
  Premise,
  Room,
  Route,
  StreetAddress,
  StreetNumber,
  Sublocality,
  SublocalityLevel1,
  SublocalityLevel2,
  SublocalityLevel3,
  SublocalityLevel4,
  SublocalityLevel5,
  Subpremise,
  TownSquare,

}

extension GooglePlaceTypeExt on GooglePlaceType {
  static List<GooglePlaceType> types = [
    GooglePlaceType(type: GooglePlaceTypeEnum.Accounting, category: 0, code: "accounting", japaneseName: "会計事務所"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Airport, category: 0, code: "airport", japaneseName: "空港"),
    GooglePlaceType(type: GooglePlaceTypeEnum.AmusementPark, category: 0, code: "amusement_park", japaneseName: "アミューズメントパーク"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Aquarium, category: 0, code: "aquarium", japaneseName: "水族館"),
    GooglePlaceType(type: GooglePlaceTypeEnum.ArtGallery, category: 0, code: "art_gallery", japaneseName: "美術館"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Atm, category: 0, code: "atm", japaneseName: "ATM"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Bakery, category: 0, code: "bakery", japaneseName: "ベーカリー"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Bank, category: 0, code: "bank", japaneseName: "銀行"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Bar, category: 0, code: "bar", japaneseName: "バー"),
    GooglePlaceType(type: GooglePlaceTypeEnum.BeautySalon, category: 0, code: "beauty_salon", japaneseName: "美容室"),
    GooglePlaceType(type: GooglePlaceTypeEnum.BicycleStore, category: 0, code: "bicycle_store", japaneseName: "自転車屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.BookStore, category: 0, code: "book_store", japaneseName: "書店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.BowlingAlley, category: 0, code: "bowling_alley", japaneseName: "ボウリング場"),
    GooglePlaceType(type: GooglePlaceTypeEnum.BusStation, category: 0, code: "bus_station", japaneseName: "バス停"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Cafe, category: 0, code: "cafe", japaneseName: "カフェ"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Campground, category: 0, code: "campground", japaneseName: "キャンプ場"),
    GooglePlaceType(type: GooglePlaceTypeEnum.CarDealer, category: 0, code: "car_dealer", japaneseName: "カーディーラー"),
    GooglePlaceType(type: GooglePlaceTypeEnum.CarRental, category: 0, code: "car_rental", japaneseName: "レンタカー"),
    GooglePlaceType(type: GooglePlaceTypeEnum.CarRepair, category: 0, code: "car_repair", japaneseName: "自動車修理"),
    GooglePlaceType(type: GooglePlaceTypeEnum.CarWash, category: 0, code: "car_wash", japaneseName: "洗車"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Casino, category: 0, code: "casino", japaneseName: "カジノ"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Cemetery, category: 0, code: "cemetery", japaneseName: "墓地"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Church, category: 0, code: "church", japaneseName: "協会"),
    GooglePlaceType(type: GooglePlaceTypeEnum.CityHall, category: 0, code: "city_hall", japaneseName: "市役所"),
    GooglePlaceType(type: GooglePlaceTypeEnum.ClothingStore, category: 0, code: "clothing_store", japaneseName: "衣料品店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.ConvenienceStore, category: 0, code: "convenience_store", japaneseName: "コンビニエンスストア"),
    GooglePlaceType(type: GooglePlaceTypeEnum.CourtHouse, category: 0, code: "courthouse", japaneseName: "裁判所"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Dentist, category: 0, code: "dentist", japaneseName: "歯医者"),
    GooglePlaceType(type: GooglePlaceTypeEnum.DepartmentStore, category: 0, code: "department_store", japaneseName: "デパートメントストア"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Doctor, category: 0, code: "doctor", japaneseName: "病院"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Drugstore, category: 0, code: "drugstore", japaneseName: "ドラッグストア"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Electrician, category: 0, code: "electrician", japaneseName: ""),
    GooglePlaceType(type: GooglePlaceTypeEnum.ElectronicsStore, category: 0, code: "electronics_store", japaneseName: "電子製品販売店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Embassy, category: 0, code: "embassy", japaneseName: "大使館"),
    GooglePlaceType(type: GooglePlaceTypeEnum.FireStation, category: 0, code: "fire_station", japaneseName: "消防署"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Flourist, category: 0, code: "florist", japaneseName: "花屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.FuneralHome, category: 0, code: "funeral_home", japaneseName: "葬儀場"),
    GooglePlaceType(type: GooglePlaceTypeEnum.FurnitureStore, category: 0, code: "furniture_store", japaneseName: "家具店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.GasStation, category: 0, code: "gas_station", japaneseName: "ガソリンスタンド"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Gym, category: 0, code: "gym", japaneseName: "スポーツジム"),
    GooglePlaceType(type: GooglePlaceTypeEnum.HairCare, category: 0, code: "hair_care", japaneseName: "理髪店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.HardwareStore, category: 0, code: "hardware_store", japaneseName: "工具店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.HinduTemple, category: 0, code: "hindu_temple", japaneseName: "ヒンドゥー教寺院"),
    GooglePlaceType(type: GooglePlaceTypeEnum.HomeGoodsStore, category: 0, code: "home_goods_store", japaneseName: "ホームセンター"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Hospital, category: 0, code: "hospital", japaneseName: "医療機関"),
    GooglePlaceType(type: GooglePlaceTypeEnum.InsuranceAgency, category: 0, code: "insurance_agency", japaneseName: "保険代理店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.JewelryStore, category: 0, code: "jewelry_store", japaneseName: "宝石店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Laundry, category: 0, code: "laundry", japaneseName: "クリーニング店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Lawyer, category: 0, code: "lawyer", japaneseName: "法律事務所"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Library, category: 0, code: "library", japaneseName: "図書館"),
    GooglePlaceType(type: GooglePlaceTypeEnum.LightRailStation, category: 0, code: "light_rail_station", japaneseName: "路面電車停留場"),
    GooglePlaceType(type: GooglePlaceTypeEnum.LiquorStore, category: 0, code: "liquor_store", japaneseName: "酒屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.LocalGovernmentStore, category: 0, code: "local_government_office", japaneseName: "地方公共団体"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Locksmith, category: 0, code: "locksmith", japaneseName: "鍵屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Lodging, category: 0, code: "lodging", japaneseName: "宿泊施設"),
    GooglePlaceType(type: GooglePlaceTypeEnum.MealDelivery, category: 0, code: "meal_delivery", japaneseName: "飲食店(出前あり)"),
    GooglePlaceType(type: GooglePlaceTypeEnum.MealTakeaway, category: 0, code: "meal_takeaway", japaneseName: "飲食店(テイクアウト可)"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Mosque, category: 0, code: "mosque", japaneseName: "モスク"),
    GooglePlaceType(type: GooglePlaceTypeEnum.MovieRental, category: 0, code: "movie_rental", japaneseName: "レンタルビデオ"),
    GooglePlaceType(type: GooglePlaceTypeEnum.MovieTheater, category: 0, code: "movie_theater", japaneseName: "映画館"),
    GooglePlaceType(type: GooglePlaceTypeEnum.MovingCompany, category: 0, code: "moving_company", japaneseName: "運送屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Museum, category: 0, code: "museum", japaneseName: "博物館"),
    GooglePlaceType(type: GooglePlaceTypeEnum.NightClub, category: 0, code: "night_club", japaneseName: "ナイトクラブ"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Painter, category: 0, code: "painter", japaneseName: "塗装屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Park, category: 0, code: "park", japaneseName: "公園"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PetStore, category: 0, code: "pet_store", japaneseName: "ペットショップ"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Pharmacy, category: 0, code: "pharmacy", japaneseName: "薬局"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Psysiotherapist, category: 0, code: "physiotherapist", japaneseName: "理学療法"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Police, category: 0, code: "police", japaneseName: "警察署"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PostOffice, category: 0, code: "post_office", japaneseName: "郵便局"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PrimarySchool, category: 0, code: "primary_school", japaneseName: "小学校"),
    GooglePlaceType(type: GooglePlaceTypeEnum.RealEstateAgency, category: 0, code: "real_estate_agency", japaneseName: "不動産屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Restaurant, category: 0, code: "restaurant", japaneseName: "レストラン"),
    GooglePlaceType(type: GooglePlaceTypeEnum.RoofingContractor, category: 0, code: "roofing_contractor", japaneseName: "屋根屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.RvPark, category: 0, code: "rv_park", japaneseName: "RVパーク"),
    GooglePlaceType(type: GooglePlaceTypeEnum.School, category: 0, code: "school", japaneseName: "学校"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SecondarySchool, category: 0, code: "secondary_school", japaneseName: "中学校"),
    GooglePlaceType(type: GooglePlaceTypeEnum.ShoeStore, category: 0, code: "shoe_store", japaneseName: "靴屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.ShoppingMall, category: 0, code: "shopping_mall", japaneseName: "ショッピングモール"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Spa, category: 0, code: "spa", japaneseName: "銭湯"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Stadium, category: 0, code: "stadium", japaneseName: "スタジアム"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Storage, category: 0, code: "storage", japaneseName: "倉庫"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Store, category: 0, code: "store", japaneseName: "店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SubwayStation, category: 0, code: "subway_station", japaneseName: "地下鉄駅"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Supermarket, category: 0, code: "supermarket", japaneseName: "スーパーマーケット"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Synagogue, category: 0, code: "synagogue", japaneseName: "シナゴーグ"),
    GooglePlaceType(type: GooglePlaceTypeEnum.TaxiStand, category: 0, code: "taxi_stand", japaneseName: "タクシー乗り場"),
    GooglePlaceType(type: GooglePlaceTypeEnum.TouristAttraction, category: 0, code: "tourist_attraction", japaneseName: "観光地"),
    GooglePlaceType(type: GooglePlaceTypeEnum.TrainStation, category: 0, code: "train_station", japaneseName: "鉄道駅"),
    GooglePlaceType(type: GooglePlaceTypeEnum.TransitStation, category: 0, code: "transit_station", japaneseName: "通過駅"),
    GooglePlaceType(type: GooglePlaceTypeEnum.TravelAgency, category: 0, code: "travel_agency", japaneseName: "旅行代理店"),
    GooglePlaceType(type: GooglePlaceTypeEnum.University, category: 0, code: "university", japaneseName: "大学"),
    GooglePlaceType(type: GooglePlaceTypeEnum.VeterinaryCare, category: 0, code: "veterinary_care", japaneseName: "動物病院"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Zoo, category: 0, code: "zoo", japaneseName: "動物園"),

    GooglePlaceType(type: GooglePlaceTypeEnum.AdministrativeAreaLevel1, category: 1, code: "administrative_area_level_1", japaneseName: "住所大分類1"),
    GooglePlaceType(type: GooglePlaceTypeEnum.AdministrativeAreaLevel2, category: 1, code: "administrative_area_level_2", japaneseName: "住所大分類2"),
    GooglePlaceType(type: GooglePlaceTypeEnum.AdministrativeAreaLevel3, category: 1, code: "administrative_area_level_3", japaneseName: "住所大分類3"),
    GooglePlaceType(type: GooglePlaceTypeEnum.AdministrativeAreaLevel4, category: 1, code: "administrative_area_level_4", japaneseName: "住所大分類4"),
    GooglePlaceType(type: GooglePlaceTypeEnum.AdministrativeAreaLevel5, category: 1, code: "administrative_area_level_5", japaneseName: "住所大分類5"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Archipelago, category: 1, code: "archipelago", japaneseName: "群島"),
    GooglePlaceType(type: GooglePlaceTypeEnum.ColloquialArea, category: 1, code: "colloquial_area", japaneseName: "場所"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Continent, category: 1, code: "continent", japaneseName: "大陸"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Country, category: 1, code: "country", japaneseName: "国"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Establishment, category: 1, code: "establishment", japaneseName: "建造物"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Finance, category: 1, code: "finance", japaneseName: "金融"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Floor, category: 1, code: "floor", japaneseName: "フロア"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Food, category: 1, code: "food", japaneseName: "食"),
    GooglePlaceType(type: GooglePlaceTypeEnum.GeneralContractor, category: 1, code: "general_contractor", japaneseName: "ゼネコン"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Geocode, category: 1, code: "geocode", japaneseName: "地理座標"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Health, category: 1, code: "health", japaneseName: "医療機関"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Intersection, category: 1, code: "intersection", japaneseName: "交差点"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Landmark, category: 1, code: "landmark", japaneseName: "ランドマーク"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Locality, category: 1, code: "locality", japaneseName: "地方"),
    GooglePlaceType(type: GooglePlaceTypeEnum.NaturalFeature, category: 1, code: "natural_feature", japaneseName: "自然地形"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Neighborhood, category: 1, code: "neighborhood", japaneseName: "近郊"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PlaceOfWorship, category: 1, code: "place_of_worship", japaneseName: "礼拝所"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PlusCode, category: 1, code: "plus_code", japaneseName: "Plusコード"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PointOfInterest, category: 1, code: "point_of_interest", japaneseName: "人気がある"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Political, category: 1, code: "political", japaneseName: "政治"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PostBox, category: 1, code: "post_box", japaneseName: "郵便ポスト"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PostalCode, category: 1, code: "postal_code", japaneseName: "郵便番号"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PostalCodePrefix, category: 1, code: "postal_code_prefix", japaneseName: "郵便番号（前半）"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PostalCodeSuffix, category: 1, code: "postal_code_suffix", japaneseName: "郵便番号（後半）"),
    GooglePlaceType(type: GooglePlaceTypeEnum.PostalTown, category: 1, code: "postal_town", japaneseName: "郵便街"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Premise, category: 1, code: "premise", japaneseName: "建物"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Room, category: 1, code: "room", japaneseName: "部屋"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Route, category: 1, code: "route", japaneseName: "道路"),
    GooglePlaceType(type: GooglePlaceTypeEnum.StreetAddress, category: 1, code: "street_address", japaneseName: "街路名"),
    GooglePlaceType(type: GooglePlaceTypeEnum.StreetNumber, category: 1, code: "street_number", japaneseName: "街路番号"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Sublocality, category: 1, code: "sublocality", japaneseName: "住所小分類"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SublocalityLevel1, category: 1, code: "sublocality_level_1", japaneseName: "住所小分類1"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SublocalityLevel2, category: 1, code: "sublocality_level_2", japaneseName: "住所小分類2"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SublocalityLevel3, category: 1, code: "sublocality_level_3", japaneseName: "住所小分類3"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SublocalityLevel4, category: 1, code: "sublocality_level_4", japaneseName: "住所小分類4"),
    GooglePlaceType(type: GooglePlaceTypeEnum.SublocalityLevel5, category: 1, code: "sublocality_level_5", japaneseName: "住所小分類5"),
    GooglePlaceType(type: GooglePlaceTypeEnum.Subpremise, category: 1, code: "subpremise", japaneseName: "建物"),
    GooglePlaceType(type: GooglePlaceTypeEnum.TownSquare, category: 1, code: "town_square", japaneseName: "広場"),
  ];

  static GooglePlaceType fromCode(String code) {
    var result = GooglePlaceTypeExt.types.singleWhere((type) => type.code == code, orElse: () => null);
    return result;
  }
}
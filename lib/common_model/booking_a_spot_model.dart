class BookingASpotModel{
  final int bookingId;

  BookingASpotModel({required this.bookingId});

  factory BookingASpotModel.fromJson(Map<String,dynamic> json) => BookingASpotModel(bookingId: json['id']);
}
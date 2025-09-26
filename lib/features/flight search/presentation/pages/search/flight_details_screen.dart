import 'package:flight_search_app/features/flight%20search/domain/entities/flight.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/appbar.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/colors.dart';
import 'package:flight_search_app/features/flight%20search/presentation/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flight_search_app/gen/assets.gen.dart';

class FlightDetailsScreen extends StatelessWidget {
  final Flight flight;

  const FlightDetailsScreen({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: CustomAppBar(
        icon: Icon(Icons.close, size: 24.spMin, color: black),
        title: 'Flight Details',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.spMin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.spMin),

                    // Flight header with price
                    Container(
                      padding: EdgeInsets.all(16.spMin),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12.spMin),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28.spMin,
                            backgroundColor: lightGrey2,
                            backgroundImage: flight.airlineLogo != null
                                ? NetworkImage(flight.airlineLogo!)
                                : null,
                            child: flight.airlineLogo == null
                                ? Icon(
                                    Icons.flight,
                                    size: 28.spMin,
                                    color: black,
                                  )
                                : null,
                          ),
                          SizedBox(width: 16.spMin),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: flight.airlineName,
                                  fontSize: 18.spMin,
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                ),
                                SizedBox(height: 4.spMin),
                                CustomTextWidget(
                                  text: 'Flight No: ${flight.flightNumber}',
                                  fontSize: 14.spMin,
                                  color: lightGrey4,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(height: 4.spMin),
                                CustomTextWidget(
                                  text:
                                      'Status: ${flight.flightStatus.toUpperCase()}',
                                  fontSize: 14.spMin,
                                  color: _getStatusColor(flight.flightStatus),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomTextWidget(
                                text: '\$${flight.price.toStringAsFixed(0)}',
                                fontSize: 20.spMin,
                                color: blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomTextWidget(
                                text: flight.duration,
                                fontSize: 14.spMin,
                                color: lightGrey4,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.spMin),

                    // Route information
                    Container(
                      padding: EdgeInsets.all(16.spMin),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12.spMin),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildRouteRow(
                            icon: Icons.flight_takeoff,
                            title: 'Departure',
                            airport: flight.departureAirport,
                            iata: flight.departureIata,
                            time: flight.formattedDepartureTime,
                            date: flight.flightDate,
                          ),
                          SizedBox(height: 16.spMin),
                          Divider(color: lightGrey2, height: 1),
                          SizedBox(height: 16.spMin),
                          _buildRouteRow(
                            icon: Icons.flight_land,
                            title: 'Arrival',
                            airport: flight.arrivalAirport,
                            iata: flight.arrivalIata,
                            time: flight.formattedArrivalTime,
                            date: flight.flightDate,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.spMin),

                    // Flight information
                    Container(
                      padding: EdgeInsets.all(16.spMin),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12.spMin),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'Flight Information',
                            fontSize: 18.spMin,
                            color: black,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(height: 16.spMin),
                          _buildInfoRow(
                            icon: Assets.svg.duration.svg(),
                            title: 'Total Duration',
                            value: flight.duration,
                          ),
                          SizedBox(height: 16.spMin),
                          _buildInfoRow(
                            icon: Assets.svg.stops.svg(),
                            title: 'Stops',
                            value: flight.stops == 0
                                ? 'Non-stop'
                                : '${flight.stops} stop${flight.stops > 1 ? 's' : ''}',
                          ),
                          if (flight.aircraft != null) ...[
                            SizedBox(height: 16.spMin),
                            _buildInfoRow(
                              icon: Assets.svg.aircraft.svg(),
                              title: 'Aircraft',
                              value: flight.aircraft!,
                            ),
                          ],
                          SizedBox(height: 16.spMin),
                          _buildInfoRow(
                            icon: Icon(
                              Icons.calendar_today,
                              size: 20.spMin,
                              color: lightGrey4,
                            ),
                            title: 'Flight Date',
                            value: flight.flightDate,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.spMin),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteRow({
    required IconData icon,
    required String title,
    required String airport,
    required String iata,
    required String time,
    required String date,
  }) {
    return Row(
      children: [
        Icon(icon, size: 24.spMin, color: blueAccent),
        SizedBox(width: 12.spMin),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: title,
                fontSize: 14.spMin,
                color: lightGrey4,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 4.spMin),
              CustomTextWidget(
                text: airport,
                fontSize: 16.spMin,
                color: black,
                fontWeight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: '$iata • $time • $date',
                fontSize: 12.spMin,
                color: lightGrey4,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required Widget icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        SizedBox(width: 24.spMin, height: 24.spMin, child: icon),
        SizedBox(width: 12.spMin),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: title,
                fontSize: 14.spMin,
                color: lightGrey4,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 2.spMin),
              CustomTextWidget(
                text: value,
                fontSize: 16.spMin,
                color: black,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return Colors.blue;
      case 'active':
        return Colors.green;
      case 'landed':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}

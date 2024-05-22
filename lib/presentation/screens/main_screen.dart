import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reservation_app/bloc/bloc.dart';
import 'package:reservation_app/core/presentation/widgets/rectangle_button_widget.dart';
import 'package:reservation_app/core/services/logger_service.dart';
import 'package:reservation_app/core/utils/constants/app_assets.dart';
import 'package:reservation_app/model/reservation.dart';
import 'package:reservation_app/presentation/widgets/reservations_list_widget.dart';
import 'package:reservation_app/presentation/widgets/tickets_list_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      reservationsBloc.add(const GetReservations());
    });
  }

// s

  setIsDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  onTapOpenReservation() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: null,
            body: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    splashColor: Colors.transparent,
                    child: Container(),
                  ),
                ),
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Container(
                        width: 1.sw,
                        child: Column(
                          children: [
                            Container(
                              //   height: 30.h,
                              color: isDarkMode ? const Color.fromRGBO(34, 34, 34, 1) : const Color.fromRGBO(255, 255, 255, 1),
                              //   alignment: Alignment.center,
                              child: Center(
                                child: Container(
                                  height: 6.h,
                                  width: 56.w,
                                  margin: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.white.withOpacity(0.63) : Colors.black.withOpacity(0.63),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            //body
                            Container(
                                // padding: EdgeInsets.on(vertical: 61.h),
                                color: isDarkMode ? Colors.black : const Color.fromRGBO(250, 250, 250, 1),
                                height: 0.8.sh,
                                child: ReservationsListWidget(
                                  isDarkMode: isDarkMode,
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  onTapIOSTicket() {}

  onTapAndroidTicket() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: null,
            body: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    splashColor: Colors.transparent,
                    child: Container(),
                  ),
                ),
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      color: Colors.transparent,
                      child: Container(
                        width: 1.sw,
                        child: Column(
                          children: [
                            Container(
                              //   height: 30.h,
                              color: isDarkMode ? const Color.fromRGBO(34, 34, 34, 1) : const Color.fromRGBO(255, 255, 255, 1),
                              //   alignment: Alignment.center,
                              child: Center(
                                child: Container(
                                  height: 6.h,
                                  width: 56.w,
                                  margin: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.white.withOpacity(0.63) : Colors.black.withOpacity(0.63),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            //body
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 61.h),
                                color: isDarkMode ? Colors.black : const Color.fromRGBO(250, 250, 250, 1),
                                child: BlocProvider.value(
                                  value: reservationsBloc,
                                  child: BlocBuilder<ReservationsBloc, ReservationsState>(builder: (context, state) {
                                    LoggerService.log("state $state");
                                    if (state is ReservationsListLoaded) {
                                      List<Reservation> reservations = state.reservations ?? [];

                                      return TicketsListWidget(
                                        isDarkMode: isDarkMode,
                                        userTickets: reservations.first.userTickets!,
                                        addExtraHorizontalPadding: true,
                                      );
                                    }
                                    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                        height: 50.w,
                                        child: CircularProgressIndicator(
                                          color: isDarkMode ? Colors.white : Colors.black,
                                        ),
                                      )
                                    ]);
                                  }),
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        //   create: (context) => moviesBloc,
        //   child:
        Scaffold(
            extendBody: true,
            //   bottomNavigationBar: const NavigationBarWidget(),
            appBar: AppBar(
              toolbarHeight: 0,
              foregroundColor: isDarkMode ? Color.fromRGBO(239, 239, 239, 1) : Color.fromRGBO(23, 23, 23, 1),
              backgroundColor: isDarkMode ? Color.fromRGBO(23, 23, 23, 1) : Color.fromRGBO(239, 239, 239, 1),
              // title: Text(widget.title),
            ),
            body: _buildBody());
    // );
  }

  _buildBody() {
    return Container(
      color: isDarkMode ? Color.fromRGBO(23, 23, 23, 1) : Color.fromRGBO(239, 239, 239, 1),
      padding: EdgeInsetsDirectional.only(start: 32.w, end: 30.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildPageHeader(),
            // const SizedBox(
            //   height: 16,
            // ),
            const Spacer(),
            RectangleButtonWidget(
              fillColor: isDarkMode ? const Color.fromRGBO(224, 230, 243, 1) : const Color.fromRGBO(14, 26, 45, 1),
              onPress: onTapOpenReservation,
              width: 286.w,
              height: 51.h,
              textColor: isDarkMode ? const Color.fromRGBO(14, 26, 45, 1) : const Color.fromRGBO(224, 230, 243, 1),
              text: 'Open Reservation',
              roundedCorners: false,
            ),
            SizedBox(
              height: 24.h,
            ),
            RectangleButtonWidget(
              fillColor: isDarkMode ? const Color.fromRGBO(23, 23, 23, 1) : const Color.fromRGBO(239, 239, 239, 1),
              onPress: () {},
              width: 286.w,
              height: 51.h,
              textColor: isDarkMode ? const Color.fromRGBO(224, 230, 243, 1) : const Color.fromRGBO(14, 26, 45, 1),
              text: 'Show IOS Ticket',
              roundedCorners: false,
              borderColor: isDarkMode ? const Color.fromRGBO(224, 230, 243, 1) : const Color.fromRGBO(14, 26, 45, 1),
            ),
            SizedBox(
              height: 24.h,
            ),
            RectangleButtonWidget(
              fillColor: isDarkMode ? Color.fromRGBO(23, 23, 23, 1) : Color.fromRGBO(239, 239, 239, 1),
              onPress: onTapAndroidTicket,
              width: 286.w,
              height: 51.h,
              textColor: isDarkMode ? const Color.fromRGBO(224, 230, 243, 1) : const Color.fromRGBO(14, 26, 45, 1),
              text: 'Show Android Ticket',
              roundedCorners: false,
            ),
            SizedBox(
              height: 77.h,
            )
            // TextButton(
            //     onPressed: () {},
            //     style: ButtonStyle(
            //         shape: MaterialStateProperty.all(Outlin),
            //         backgroundColor: MaterialStateProperty.all<Color>(
            //             isDarkMode ? const Color.fromRGBO(224, 230, 243, 1) : const Color.fromRGBO(144, 26, 45, 1))),
            //     child: Text(
            //       'Open Reservation',
            //       style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w700,
            //           color: isDarkMode ? const Color.fromRGBO(14, 26, 45, 1) : const Color.fromRGBO(224, 230, 243, 1)),
            //     ))
            // FlatButton(
            //     child: Text('LogIn', style: TextStyle(fontSize: 20.0),),
            //     color: Colors.blueAccent,
            //     textColor: Color.fromRGBO(239, 239, 239, 1),
            //     onPressed: () {},
            //   ),
            // BlocListener<MoviesBloc, MoviesState>(
            //   listener: (context, state) {
            //     if (state.message != null && state.message!.isNotEmpty) {
            //       ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message!));
            //     }
            //   },
            //   child: BlocBuilder<MoviesBloc, MoviesState>(
            //     builder: (context, state) {
            //       LoggerService.log("state $state");
            //       if (state is MoviesListLoaded || state is MovieLoaded) {
            //         List<Movie> movies = state.movies ?? [];
            //         return Expanded(
            //             child: movies.isNotEmpty
            //                 ? ListView(shrinkWrap: true, children: [_buildMoviesList(movies)])
            //                 : const SingleChildScrollView(
            //                     physics: AlwaysScrollableScrollPhysics(),
            //                     child: Text('No Movies found'),
            //                   ));
            //       }
            //       if (state is Error) return Text(state.message ?? '');

            //       return _buildLoading();
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  _buildLoading() {
    return Column(children: [
      SizedBox(
        height: 100.h,
      ),
      SizedBox(
        width: 104,
        height: 104,
        child: CircularProgressIndicator(
          color: isDarkMode ? Color.fromRGBO(239, 239, 239, 1) : Color.fromRGBO(239, 239, 239, 1),
        ),
      )
    ]);
  }

  _buildPageHeader() {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.themeIcon,
                width: 26.w,
                height: 26.w,
                colorFilter: ColorFilter.mode(
                    isDarkMode ? Color.fromRGBO(239, 239, 239, 1) : Color.fromRGBO(23, 23, 23, 1), BlendMode.srcIn),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                "Theme",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Color.fromRGBO(239, 239, 239, 1) : Color.fromRGBO(23, 23, 23, 1)),
              )
            ],
          ),
          InkWell(
            onTap: () => setIsDarkMode(!isDarkMode),
            child: Container(
              width: 74.w,
              height: 34.h,
              padding: EdgeInsets.only(left: 6.w, right: 6.w),
              decoration: BoxDecoration(
                  color: isDarkMode ? const Color.fromRGBO(53, 56, 52, 1) : const Color.fromRGBO(227, 227, 227, 1),
                  borderRadius: BorderRadius.circular(26),
                  border:
                      Border.all(color: isDarkMode ? const Color.fromRGBO(86, 95, 109, 1) : const Color.fromRGBO(4, 19, 43, 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDarkMode ? _buildThemeCircle() : _buildThemeIcon(),
                  isDarkMode ? _buildThemeIcon() : _buildThemeCircle()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildThemeCircle() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? const Color.fromRGBO(87, 94, 105, 1) : const Color.fromRGBO(4, 19, 43, 1),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.14),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 4,
            )
          ]),
    );
  }

  _buildThemeIcon() {
    return SvgPicture.asset(isDarkMode ? AppAssets.sunIcon : AppAssets.moonIcon);
  }
}

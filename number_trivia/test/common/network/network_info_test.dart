import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/common/network/network_info.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  NetworkInfoImpl? networkInfo;
  final mockConnectivity = MockConnectivity();

  setUp(() {
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test(
      'should forward the call to Connectivity.checkConnectivity',
      () async {
        // arrange
        final tHasConnectionFuture = true;

        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => Future.value(ConnectivityResult.mobile));
        // act
        final result = await networkInfo!.isConnected;

        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, tHasConnectionFuture);
      },
    );
  });
}

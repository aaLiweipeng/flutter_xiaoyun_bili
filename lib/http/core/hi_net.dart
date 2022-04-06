import '../request/base_request.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class HiNet {
  HiNet._();
  static HiNet? _instance;

  /// 饿汉单例模式
  static HiNet? getInstance() {
    _instance ??= HiNet?._();
    return _instance;
  }

  Future fire(BaseRequest request) async {

    // test code begin 1 [use this test code in main.dart]
    var response = await send(request);
    var result = response['data'];
    printLog(result);
    return result;
    // test code end 1


    // HiNetResponse response;
    // var error;
    // try {
    //   response = await send(request);
    // } on HiNetError catch (e) {
    //   error = e;
    //   response = e.data;
    //   printLog(e.message);
    // } catch (e) {
    //   //其它异常
    //   error = e;
    //   printLog(e);
    // }
    // if (response == null) {
    //   printLog(error);
    // }
    // var result = response.data;
    // printLog(result);
    // var status = response.statusCode;
    // switch (status) {
    //   case 200:
    //     return result;
    //     break;
    //   case 401:
    //     throw NeedLogin();
    //     break;
    //   case 403:
    //     throw NeedAuth(result.toString(), data: result);
    //     break;
    //   default:
    //     throw HiNetError(status, result.toString(), data: result);
    //     break;
    // }
  }

  //test code begin 1
  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    printLog('method:${request.httpMethod()}');
    printLog('params:${request.params}');
    request.addHeader("token", "123123");
    printLog('header:${request.header}');
    return Future.value({
      "statusCode": 200,
      "data":{"code":0, "message": 'success'}
    });
  }
  //test code end 1

  // Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
  //   ///使用Dio发送请求
  //   HiNetAdapter adapter = DioAdapter();
  //   return adapter.send(request);
  // }

  void printLog(log) {
    print('hi_net:' + log.toString());
  }
}

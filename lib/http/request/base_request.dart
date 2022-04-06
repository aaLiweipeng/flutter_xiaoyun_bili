///枚举
enum HttpMethod { GET, POST, DELETE }

///基础请求  注意是抽象类
abstract class BaseRequest {
  ///需要支持两种形式的 请求URL
  // curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=11" -H "accept: */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1

  var pathParams;
  var useHttps = true;//默认使用https请求
  final authNextString = "/mock/ce30c8e3704c9b32695d2676b4208519/api-xiaoyun-bili";

  ///设置项目的 API域名【服务器对应项目的统一域名】
  String authority() {
    // return "api.devio.org";
    return "www.fastmock.site";
  }

  /// 函数 用于设置请求方法（通过return的方式）
  HttpMethod httpMethod();

  /// 函数 设置URL中，项目统一URL后的 功能api URL路径，如“/uapi/test/test”
  String path();

  String url() {
    Uri uri;
    var pathStr = path();

    //拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    //http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), authNextString + pathStr, params);
    } else {
      uri = Uri.http(authority(), authNextString + pathStr, params);
    }
    print('url:${uri.toString()}');
    return uri.toString();
  }

  ///函数 返回一个值 用于区分接口 需不需要登录
  bool needLogin();

  ///成员字段  查询参数
  Map<String, String> params = Map();
  ///添加参数  键值对  【返回this，方便链式调用】
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  ///成员字段  头部参数
  Map<String, dynamic> header = Map();
  ///添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}

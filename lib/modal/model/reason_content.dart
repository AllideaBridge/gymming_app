class ReasonContent{
  final String _title;
  final String _subtitle;
  final List<String> _reasons;

  ReasonContent(this._title, this._subtitle, this._reasons);

  List<String> get reasons => _reasons;

  String get subtitle => _subtitle;

  String get title => _title;
}
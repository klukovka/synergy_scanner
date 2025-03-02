sealed class TablePointer {}

/// Table not filtered by other entity
abstract final class GeneralTablePointer extends TablePointer {}

abstract final class PartnerTablePointer extends TablePointer {}

abstract final class CriteriaTablePointer extends TablePointer {}

abstract final class AnalyticsTablePointer extends TablePointer {}

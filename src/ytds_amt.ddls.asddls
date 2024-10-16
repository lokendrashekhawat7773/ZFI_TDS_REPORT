@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TDS AMT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YTDS_AMT as select from I_OperationalAcctgDocItem
{
    CompanyCode,
    AccountingDocument,
    FiscalYear,
    Supplier,
    TransactionCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'    
    WithholdingTaxBaseAmount,
   @Semantics.amount.currencyCode: 'TransactionCurrency'   
    WithholdingTaxAmount
} where FinancialAccountType = 'K'

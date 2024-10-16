@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TDS CONDITION WIT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YTDS_AMT_1 as select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( B.AccountingDocument = A.AccountingDocument 
    and B.FiscalYear = A.FiscalYear and B.CompanyCode = A.CompanyCode and A.TransactionTypeDetermination = 'WIT' and A.FinancialAccountType = 'S' )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
//     left outer join YTDS_AMT as C on
//  ( C.AccountingDocument = A.AccountingDocument   
//    and C.FiscalYear = A.FiscalYear and C.CompanyCode = A.CompanyCode )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
                
{
key A.CompanyCode,
key A.AccountingDocument,
//key A.AccountingDocumentItem,
key A.FiscalYear,
    B.ControllingArea,
    B.ProfitCenter,
    B.TransactionCurrency,
    B.BusinessPlace,
    B.TaxSection,
    B.TransactionTypeDetermination,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
 @Semantics.amount.currencyCode: 'TransactionCurrency'    
    C.WithholdingTaxBaseAmount,
 @Semantics.amount.currencyCode: 'TransactionCurrency'   
    C.WithholdingTaxAmount,
    B.TaxCode,
    D.PostingDate   
} where B.ProfitCenter <> '' // and D.WithholdingTaxCode <> ''

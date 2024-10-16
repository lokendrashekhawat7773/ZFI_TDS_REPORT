@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TDS REPORT'
define view  entity YTDS_REP1 as select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode and B.TransactionTypeDetermination = 'WIT' and A.FinancialAccountType = 'S' )   
  
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
key A.FiscalYear,
    A.AccountingDocumentItem, 
    A.ProfitCenter , 
    A.TransactionCurrency ,     
    @Semantics.amount.currencyCode: 'TransactionCurrency'    
    A.AmountInTransactionCurrency as WithholdingTaxBaseAmount,    
    B.ControllingArea ,
    B.BusinessPlace,
    B.TaxSection,
    B.TransactionTypeDetermination,
    B.WithholdingTaxCode,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    B.AmountInTransactionCurrency as WithholdingTaxAmount,    
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
// @Semantics.amount.currencyCode: 'TransactionCurrency'    
//    C.WithholdingTaxBaseAmount,
// @Semantics.amount.currencyCode: 'TransactionCurrency'   
//    C.WithholdingTaxAmount,
    B.TaxCode,
    D.PostingDate   
} where  A.AccountingDocumentType = 'KR'
   and  A.ProfitCenter <> ' '
   and A.GLAccount <> '0040503170'
// and B.ProfitCenter <> '' // and D.WithholdingTaxCode <> ''

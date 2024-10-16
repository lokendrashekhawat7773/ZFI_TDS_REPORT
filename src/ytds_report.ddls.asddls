
@AbapCatalog.sqlViewName: 'ZTDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TDS REPORT'
define view YTDS_REPORT as select from ZFI_TDS_REPORT_FIN as a

{ 
 
 key CompanyCode,
 key AccountingDocument,
 key FiscalYear,
 AccountingDocumentItem,
 GLAccount,
 ProfitCenter,
 TransactionCurrency,
 WithholdingTaxAmount,
 ControllingArea,
 BusinessPlace,
 TaxSection,
 TransactionTypeDetermination,
 sum(WithholdingTaxBaseAmount) as WithholdingTaxBaseAmount,
 WithholdingTaxCode,
 Supplier,
 SupplierName,
 PAN_NO,
 TaxNumber3,
 TaxCode,
 PostingDate,
 AccountingDocCreatedByUser,
 PersonFullName,
 AccountingDocumentType
 

 
 }  
   where  TransactionTypeDetermination = 'EGK'  or  TransactionTypeDetermination = '' 
        or  TransactionTypeDetermination = 'WIT' or  TransactionTypeDetermination = 'WRX' 
        or  TransactionTypeDetermination = 'BSX' 
        and  ProfitCenter != ''  
        and AccountingDocumentType != 'WE' or AccountingDocumentType != 'DZ'
        
group by

 CompanyCode,
 AccountingDocument,
 FiscalYear,
 AccountingDocumentItem,
 GLAccount,
 ProfitCenter,
 TransactionCurrency,
 WithholdingTaxAmount,
 ControllingArea,
 BusinessPlace,
 TaxSection,
 TransactionTypeDetermination,
 WithholdingTaxCode,
 Supplier,
 SupplierName,
 PAN_NO,
 TaxNumber3,
 TaxCode,
 PostingDate,
 AccountingDocCreatedByUser,
 PersonFullName,
 AccountingDocumentType        
        
        
 
@AbapCatalog.sqlViewName: 'ZWITHHOLDING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Withholding data'
define view YWITHHOLDING as 
select from I_OperationalAcctgDocItem as a 
    left outer join I_SupplierWithHoldingTax as b on ( b.CompanyCode = a.CompanyCode and b.Supplier = a.Supplier )
        left outer join I_Supplier as E  on ( E.Supplier = a.Supplier )                                                    
{

    key a.CompanyCode,
    key a.FiscalYear,
    a.AccountingDocument,
    a.AccountingDocumentItem,
    b.WithholdingTaxCertificate,
    a.WithholdingTaxCode,
    a.AmountInTransactionCurrency,
    a.Supplier,
    a.PostingDate,
    E.SupplierName,
    a.TransactionTypeDetermination,
    a.TaxSection,
    a.BusinessPlace,
    E.TaxNumber3
}
where a.Supplier is not initial and a.DebitCreditCode = 'H'
and b.WithholdingTaxCertificate <> ''

@AbapCatalog.sqlViewName: 'YTDSREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Tds Report'
define view ZFI_TDS_REPORT_FIN as select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode and A.TransactionTypeDetermination = 'WIT'
    and B.FinancialAccountType = 'S'   )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode  )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> ''  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
    
inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
 
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
    A.BusinessPlace,
    A.TaxSection,
   B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
   B.AmountInTransactionCurrency   as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
    T.AccountingDocCreatedByUser,
    t1.PersonFullName,
    A.AccountingDocumentType

       
} where A.AccountingDocumentType = 'KR'  and B.CostCenter !=  ''
and A.AmountInTransactionCurrency is not initial and C.Supplier != ''
and A.GLAccount <> '0040503170' and B.GLAccount <> '0040503170' 

union 


select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode and A.TransactionTypeDetermination = ''
    and B.FinancialAccountType = 'S'   )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode  )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> ''  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
    
inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
 
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
    A.BusinessPlace,
    A.TaxSection,
   B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
   B.AmountInTransactionCurrency   as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
    T.AccountingDocCreatedByUser,
    t1.PersonFullName,
    A.AccountingDocumentType

       
} where A.AccountingDocumentType = 'KR'  and B.CostCenter !=  ''
and A.AmountInTransactionCurrency is not initial and C.Supplier != ''
and A.GLAccount <> '0040503170' and B.GLAccount <> '0040503170' 
and A.GLAccount = '0010801110' and B.GLAccount <> '0010801110'
    
union 
 
select from  I_OperationalAcctgDocItem as A
 
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and A.TransactionTypeDetermination = 'WIT'   )      
    
  inner join I_OperationalAcctgDocItem as x on ( x.AccountingDocument = A.AccountingDocument and x.FiscalYear = A.FiscalYear
           and x.CompanyCode = A.CompanyCode  and x.FinancialAccountType = 'S' )  
    
 
  left outer join I_OperationalAcctgDocItem as F on
  ( F.AccountingDocument = B.AccountingDocument 
   and F.FiscalYear = B.FiscalYear and F.CompanyCode = B.CompanyCode  
   and F.FinancialAccountType = 'S' and F.Material <> '' and F.ProfitCenter <> ''  )

  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument    
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )    
 
  left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
  left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
  inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
    
     
    {
   key A.CompanyCode,
   key A.AccountingDocument,
   key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   A.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
    A.AmountInTransactionCurrency as WithholdingTaxAmount ,
    B.ControllingArea,
    B.BusinessPlace,
    B.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    B.AmountInTransactionCurrency  as WithholdingTaxBaseAmount, 
    x.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    A.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

    }
  where  A.AccountingDocumentType = 'RE' 
    and  A.AmountInTransactionCurrency is not initial and x.WithholdingTaxCode <> ''
    and  A.GLAccount <> '0040503170' and B.GLAccount <> '0040503170'
    and (  B.TransactionTypeDetermination = 'WRX' or B.TransactionTypeDetermination = 'FR3'
          or B.TransactionTypeDetermination = 'ANL'  or B.TransactionTypeDetermination = 'FR1'
          or B.TransactionTypeDetermination = 'FR1' and  B.TransactionTypeDetermination = 'PRD' 
         or B.TransactionTypeDetermination = 'PRD'   )

union 
 
select from  I_OperationalAcctgDocItem as A
 
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and A.TransactionTypeDetermination = 'WIT'   )      
    
  inner join I_OperationalAcctgDocItem as x on ( x.AccountingDocument = A.AccountingDocument and x.FiscalYear = A.FiscalYear
           and x.CompanyCode = A.CompanyCode  and x.FinancialAccountType = 'S' )  
    
 
  left outer join I_OperationalAcctgDocItem as F on
  ( F.AccountingDocument = B.AccountingDocument 
   and F.FiscalYear = B.FiscalYear and F.CompanyCode = B.CompanyCode  
   and F.FinancialAccountType = 'S' and F.Material <> '' and F.ProfitCenter <> ''  )

  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument    
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )    
 
  left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
  left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
  inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
    
     
    {
   key A.CompanyCode,
   key A.AccountingDocument,
   key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   A.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
    A.AmountInTransactionCurrency as WithholdingTaxAmount ,
    B.ControllingArea,
    B.BusinessPlace,
    B.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    B.AmountInTransactionCurrency  as WithholdingTaxBaseAmount, 
    x.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    A.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

    }
  where  A.AccountingDocumentType = 'RE'  
    and  A.AmountInTransactionCurrency is not initial and x.WithholdingTaxCode <> ''
    and  A.GLAccount <> '0040503170' and B.GLAccount <> '0040503170'
    and  B.FinancialAccountType = 'S' and B.Supplier = ''
    and (  B.TransactionTypeDetermination = 'KBS' )

 union

 select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument  and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode 
    and A.TransactionTypeDetermination = 'WIT'   )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    B.WithholdingTaxBaseAmount  as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType
      
} where   A.AccountingDocumentType = 'KZ'  
and A.AmountInTransactionCurrency is not initial and D.WithholdingTaxCode <> '' and T.IsReversed <> 'X' and T.IsReversal <> 'X'
and ( A.GLAccount <> '0040503170' and B.GLAccount <> '0040503170' or 
     A.GLAccount = '0010801100'  and B.GLAccount = '0010700000' or 
     A.GLAccount = '0010801050'  and B.GLAccount = '0010703000' )
  
 union

 select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument  and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode 
       )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    B.WithholdingTaxBaseAmount  as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType
     
} where   A.AccountingDocumentType = 'KZ'  
and A.AmountInTransactionCurrency is not initial 
and  A.GLAccount = '0010801050'    and A.TransactionTypeDetermination = ''
and  A.Supplier = '' and A.FinancialAccountType = 'S' and A.ProfitCenter <> ''
and T.IsReversed <> 'X' and T.IsReversal <> 'X'
  
  union
select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode and A.TransactionTypeDetermination = 'WIT'  and B.FinancialAccountType = 'S' )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
    A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    B.WithholdingTaxBaseAmount  as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
   B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

       
} where B.ProfitCenter is not initial and  A.AccountingDocumentType = 'KG'
and A.AmountInTransactionCurrency is not initial 
and A.GLAccount <> '0040503170' and B.GLAccount <> '0040503170'
   

union
select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and B.FinancialAccountType = 'S' )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  

                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
      A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
//    B.AmountInTransactionCurrency as WithholdingTaxBaseAmount,
    B.WithholdingTaxBaseAmount  as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

       
} where B.ProfitCenter is not initial and  A.AccountingDocumentType = 'SA'  
and A.AmountInTransactionCurrency is not initial 
and ( A.GLAccount = '0010801050' and B.GLAccount = '0010801050' or
    A.GLAccount = '0010801060' and B.GLAccount = '0010801060' or
    A.GLAccount = '0010801050' and B.GLAccount = '0010801050' or
    A.GLAccount = '0010801080' and B.GLAccount = '0010801080' or  
    A.GLAccount = '0010802120' and B.GLAccount = '0010802120' or
    A.GLAccount = '0010802080' and B.GLAccount = '0010802080' or
    A.GLAccount = '0010801300' and B.GLAccount = '0010801300' or
    A.GLAccount = '0010801090' and B.GLAccount = '0010801090' or
    A.GLAccount = '0010801080' and B.GLAccount = '0010801080' or  
    A.GLAccount = '0040503190' and B.GLAccount = '0040503190' or
    A.GLAccount = '0010801110' and B.GLAccount = '0010801110' or
    A.GLAccount = '0010801120' and B.GLAccount = '0010801120' or
    A.GLAccount = '0010801170' and B.GLAccount = '0010801170' or
    A.GLAccount = '0010802160' and B.GLAccount = '0010802160' or
    A.GLAccount = '0010801140' and B.GLAccount = '0010801140' or
    A.GLAccount = '0010801050' and B.GLAccount = '0010801050' or
    A.GLAccount = '0010801300' and B.GLAccount = '0010801300' or
    A.GLAccount = '0010802260' and B.GLAccount = '0010802260' or
    A.GLAccount = '0010801090' and B.GLAccount = '0010801090' ) and    
    A.AccountingDocument <> '0100002735' and B.AccountingDocument <> '0100002735'
    
  union
select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and B.FinancialAccountType = 'S' )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
 inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
  
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
//    B.ProfitCenter,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
//    B.AmountInTransactionCurrency as WithholdingTaxBaseAmount,
    B.WithholdingTaxBaseAmount  as WithholdingTaxBaseAmount ,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

       
} where B.ProfitCenter is not initial and  A.AccountingDocumentType = 'JV'  
and A.AmountInTransactionCurrency is not initial 
and ( A.GLAccount = '0010801120' and B.GLAccount = '0010801120' 
or A.GLAccount = '0010801050' and B.GLAccount = '0010801050' 
or A.GLAccount = '0050000140' and B.GLAccount = '0050000140' 
or A.GLAccount = '0010801170' and B.GLAccount = '0040503190'
or A.GLAccount = '0010801110' and B.GLAccount = '0021400150'
or A.GLAccount = '0010802080' and B.GLAccount = '0010700010'
or A.GLAccount = '0010802160'
or A.GLAccount = '0010801140'
or A.GLAccount = '0010801110')

union

  select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode and A.TransactionTypeDetermination = 'WIT'  
    and B.FinancialAccountType = 'K' )  
 
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode and D.WithholdingTaxCode <> '' )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
                
{

key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
//    B.ProfitCenter,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,

    @Semantics.amount.currencyCode: 'TransactionCurrency'   
     B.WithholdingTaxBaseAmount  as WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

       
} where  A.AccountingDocumentType = 'KA'  and A.TransactionTypeDetermination = 'WIT'
and A.AmountInTransactionCurrency is not initial  and A.GLAccount <> '0040503170'


union
select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and B.FinancialAccountType = 'S' )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 
  inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
//    B.ProfitCenter,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
//        B.CompanyCodeCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
//    B.AmountInTransactionCurrency as WithholdingTaxBaseAmount,
    B.AmountInTransactionCurrency  as WithholdingTaxBaseAmount ,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType
       
} where B.ProfitCenter is not initial and  A.AccountingDocumentType = 'AB'  
and A.AmountInTransactionCurrency is not initial 
and (A.GLAccount = '0010801140' and B.GLAccount = '0010802160' )  

 union
select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and B.FinancialAccountType = 'S' )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
   A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
   A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
//    B.ProfitCenter,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
//    B.AmountInTransactionCurrency as WithholdingTaxBaseAmount,
    B.AmountInTransactionCurrency  as WithholdingTaxBaseAmount ,
    D.WithholdingTaxCode,
    C.Supplier,
    E.SupplierName,
    substring( E.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType
     
}
 where B.ProfitCenter is not initial and  A.AccountingDocumentType = 'AA'  
and A.AmountInTransactionCurrency is not initial 
and ( A.GLAccount = '0020900040' and B.GLAccount = '0010802060' )

union

select from I_OperationalAcctgDocItem as A
  left outer join I_OperationalAcctgDocItem as B on
  ( A.AccountingDocument = B.AccountingDocument 
    and A.FiscalYear = B.FiscalYear and A.CompanyCode = B.CompanyCode  and A.TransactionTypeDetermination = 'JTC'
    and B.FinancialAccountType = 'D'  )   
  
  left outer join I_OperationalAcctgDocItem as C on
  ( C.AccountingDocument = B.AccountingDocument   
    and C.FiscalYear = B.FiscalYear and C.CompanyCode = B.CompanyCode and C.FinancialAccountType = 'K' )
    
    left outer join I_OperationalAcctgDocItem as D on
  ( D.AccountingDocument = A.AccountingDocument and D.AccountingDocumentItem = A.AccountingDocumentItem  
    and D.FiscalYear = A.FiscalYear and D.CompanyCode = A.CompanyCode  )  
    
    left outer join I_Supplier as E  on ( E.Supplier = C.Supplier )
 inner join  I_JournalEntry as T on ( T.CompanyCode = A.CompanyCode and T.FiscalYear = A.FiscalYear and T.AccountingDocument = A.AccountingDocument )
 inner join I_BusinessUserBasic as t1 on  ( t1.UserID = T.AccountingDocCreatedByUser )  
 
 inner join I_BillingDocument as t2 on ( t2.AccountingDocument = A.AccountingDocument and t2.FiscalYear = A.FiscalYear 
                                          and t2.CompanyCode = A.CompanyCode )
 inner join I_Customer as t3 on ( t3.Customer = t2.SoldToParty )
                
 
                
{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
   A.AccountingDocumentItem, 
      A.GLAccount,
   B.ProfitCenter ,
   A.TransactionCurrency ,
   @Semantics.amount.currencyCode: 'TransactionCurrency'    
    A.AmountInTransactionCurrency as WithholdingTaxAmount, 
    B.ControllingArea,
//    B.ProfitCenter,
    A.BusinessPlace,
    A.TaxSection,
    B.TransactionTypeDetermination,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
  B.AmountInTransactionCurrency as WithholdingTaxBaseAmount,
//    B.WithholdingTaxBaseAmount,
    D.WithholdingTaxCode,
    t2.SoldToParty as  Supplier,
    t3.CustomerName as SupplierName,
    substring( t3.TaxNumber3, 3, 10 ) as PAN_NO, 
    E.TaxNumber3,
    B.TaxCode,
    D.PostingDate,
      T.AccountingDocCreatedByUser,
     t1.PersonFullName,
    A.AccountingDocumentType

       
} where  A.AccountingDocumentType = 'RV'  
and A.AmountInTransactionCurrency is not initial 
and ( A.GLAccount = '0010802260' and B.GLAccount = '0020900000' ) 

    
  

 @AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBookStore_AKK'
@EndUserText.label: '###GENERATED Core Data Service Entity'
@ObjectModel.semanticKey: [ 'BookStoreID' ]
define root view entity ZR_BOOKSTORE_AKK
  as select from zbookstoreakk as BookStore_AKK
{
  key uuid as UUID,
  book_store_id as BookStoreID,
  title as Title,
  author as Author,
  @Semantics.amount.currencyCode: 'PriceCurr'
  price as Price,
  published_date as PublishedDate,
  stock as Stock,
  @Semantics.amount.currencyCode: 'PriceCurr'
  //Anagha Code
    case
    when price > 500  then fltp_to_dec( cast(price as abap.fltp) *0.02 as abap.dec(15,2))
    when price > 1000 then fltp_to_dec( cast(price as abap.fltp) *0.05 as abap.dec(15,2)) 
    else cast(price as abap.dec(15,2))
    end as DiscountedPrice,
  //Anagha Code
  //discounted_price as DiscountedPrice,
  book_age as BookAge,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  }]
  price_curr as PriceCurr,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}

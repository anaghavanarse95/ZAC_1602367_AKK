@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBookStore_AKK', 
  semanticKey: [ 'BookStoreID' ]
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BOOKSTORE_AKK
  provider contract transactional_query
  as projection on ZR_BOOKSTORE_AKK
  association [1..1] to ZR_BOOKSTORE_AKK as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  BookStoreID,
  Title,
  Author,
  @Semantics: {
    amount.currencyCode: 'PriceCurr'
  }
  Price,
  PublishedDate,
  Stock,
@Semantics: { amount.currencyCode: 'PriceCurr' }
  DiscountedPrice,
  BookAge ,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  PriceCurr,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}

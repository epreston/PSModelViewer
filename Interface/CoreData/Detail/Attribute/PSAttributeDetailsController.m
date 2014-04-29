//
//  PSAttributeDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSAttributeDetailsController.h"


@implementation PSAttributeDetailsController

- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
        
        
        // Validation
        // – validationPredicates
        // – validationWarnings
        
		// Getting Features of a Property (common to all properties)
		_propertyName.text = [_detailAttributeDescription name];
		_relatedEntityName.text = [[_detailAttributeDescription entity] name];
		_propertyIsIndexed.text = ( _detailAttributeDescription.isIndexed ) ? @"Yes" : @"No";
		_propertyIsOptional.text = ( _detailAttributeDescription.isOptional ) ? @"Yes" : @"No";
		_propertyIsTransient.text = ( _detailAttributeDescription.isTransient ) ? @"Yes" : @"No";
		
		// Getting and Setting Type Information
		_attributeType.text = [self nameFromAttributeType:[_detailAttributeDescription attributeType]];
		_attributeValueClassName.text = [_detailAttributeDescription attributeValueClassName];
        
        // Value Transformers
		_attributeValueTransformerName.text = [_detailAttributeDescription valueTransformerName];
		
		// Getting and Setting the Default Value
		switch ([_detailAttributeDescription attributeType]) {
			case NSUndefinedAttributeType:
			case NSBinaryDataAttributeType:
			case NSTransformableAttributeType:
			case NSObjectIDAttributeType:
				_attributeDefaultValue.text = @"not used";
				_attributeDefaultValue.enabled = NO;
				break;
			case NSStringAttributeType:
				_attributeDefaultValue.text = [_detailAttributeDescription defaultValue];
				break;
			case NSDateAttributeType:
				_attributeDefaultValue.text = [[_detailAttributeDescription defaultValue] description];
				break;
			case NSBooleanAttributeType:
				_attributeDefaultValue.text = ( [[_detailAttributeDescription defaultValue] intValue]  == 1 ) ? @"Yes" : @"No";
				break;
			default:
				_attributeDefaultValue.text = [[_detailAttributeDescription defaultValue] stringValue];
				break;
		}
	}
}


#pragma mark - Internal Helper Methods

- (NSString *) nameFromAttributeType:(NSAttributeType)type 
{
	switch (type) {
		case NSUndefinedAttributeType:
			return @"Undefined";
			break;
		case NSInteger16AttributeType:
			return @"Integer 16";
			break;
		case NSInteger32AttributeType:
			return @"Integer 32";
			break;
		case NSInteger64AttributeType:
			return @"Integer 64";
			break;
		case NSDecimalAttributeType:
			return @"Decimal";
			break;
		case NSDoubleAttributeType:
			return @"Double";
			break;
		case NSFloatAttributeType:
			return @"Float";
			break;
		case NSStringAttributeType:
			return @"String";
			break;
		case NSBooleanAttributeType:
			return @"Boolean";
			break;
		case NSDateAttributeType:
			return @"Date";
			break;
		case NSBinaryDataAttributeType:
			return @"Binary";
			break;
		case NSTransformableAttributeType:
			return @"Transformable";
			break;
		case NSObjectIDAttributeType:
			return @"Object ID";
			break;
		default:
			return @"Unknown";
			break;
	}
}


#pragma mark - UIViewController

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload
{
    self.relatedEntityName = nil;
    self.propertyIsIndexed = nil;
    self.propertyIsOptional = nil;
    self.propertyIsTransient = nil;
    self.propertyName = nil;
    self.attributeType = nil;
    self.attributeValueClassName = nil;
    self.attributeDefaultValue = nil;
    self.attributeValueTransformerName = nil;
    
    [super viewDidUnload];
}


@end

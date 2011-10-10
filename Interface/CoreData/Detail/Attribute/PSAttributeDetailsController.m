//
//  PSAttributeDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//

#import "PSAttributeDetailsController.h"


@interface PSAttributeDetailsController ()

- (void) configureView;
- (NSString *) nameFromAttributeType:(NSAttributeType)type;

@end


@implementation PSAttributeDetailsController

// Data objects
@synthesize detailAttributeDescription = detailAttributeDescription_;

// Interface
@synthesize relatedEntityName       = relatedEntityName_;
@synthesize propertyIsIndexed       = propertyIsIndexed_;
@synthesize propertyIsOptional      = propertyIsOptional_;
@synthesize propertyIsTransient     = propertyIsTransient_;
@synthesize propertyName            = propertyName_;

@synthesize attributeType           = attributeType_;
@synthesize attributeValueClassName = attributeValueClassName_;
@synthesize attributeDefaultValue   = attributeDefaultValue_;
@synthesize attributeValueTransformerName = attributeValueTransformerName_;


- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		propertyName_.text = [detailAttributeDescription_ name];
		relatedEntityName_.text = [[detailAttributeDescription_ entity] name];
		propertyIsIndexed_.text = ( detailAttributeDescription_.isIndexed ) ? @"Yes" : @"No";
		propertyIsOptional_.text = ( detailAttributeDescription_.isOptional ) ? @"Yes" : @"No";
		propertyIsTransient_.text = ( detailAttributeDescription_.isTransient ) ? @"Yes" : @"No";
		
		
		attributeType_.text = [self nameFromAttributeType:[detailAttributeDescription_ attributeType]];
		attributeValueClassName_.text = [detailAttributeDescription_ attributeValueClassName];
		attributeValueTransformerName_.text = [detailAttributeDescription_ valueTransformerName];
		
		
		switch ([detailAttributeDescription_ attributeType]) {
			case NSUndefinedAttributeType:
			case NSBinaryDataAttributeType:
			case NSTransformableAttributeType:
			case NSObjectIDAttributeType:
				attributeDefaultValue_.text = @"not used";
				attributeDefaultValue_.enabled = NO;
				break;
			case NSStringAttributeType:
				attributeDefaultValue_.text = [detailAttributeDescription_ defaultValue];
				break;
			case NSDateAttributeType:
				attributeDefaultValue_.text = [[detailAttributeDescription_ defaultValue] description];
				break;
			case NSBooleanAttributeType:
				attributeDefaultValue_.text = ( [[detailAttributeDescription_ defaultValue] intValue]  == 1 ) ? @"Yes" : @"No";
				break;
			default:
				attributeDefaultValue_.text = [[detailAttributeDescription_ defaultValue] stringValue];
				break;
		}
	}
}


#pragma mark - Helper Methods

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


#pragma mark - Resource Management

- (void) didReceiveMemoryWarning 
{    
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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

- (void) dealloc 
{    
	[detailAttributeDescription_ release];
	
	[super dealloc];
}


@end

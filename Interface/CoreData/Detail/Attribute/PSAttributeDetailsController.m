//
//  PSAttributeDetailsController.m
//  PSModelViewer
//
//  Created by Ed Preston on 7/5/10.
//  Copyright 2010 Preston Software. All rights reserved.
//


#import "PSAttributeDetailsController.h"


@implementation PSAttributeDetailsController

// Data objects
@synthesize detailAttributeDescription;

// Interface
@synthesize relatedEntityName;
@synthesize propertyIsIndexed;
@synthesize propertyIsOptional;
@synthesize propertyIsTransient;
@synthesize propertyName;

@synthesize attributeType;
@synthesize attributeValueClassName;
@synthesize attributeDefaultValue;
@synthesize attributeValueTransformerName;


- (void) configureView 
{	
	[super configureView];
	
	// The nib will overwrite our configuration if we are not loaded
	if ( [self isViewLoaded] ) {
		
		propertyName.text = [detailAttributeDescription name];
		relatedEntityName.text = [[detailAttributeDescription entity] name];
		propertyIsIndexed.text = ( detailAttributeDescription.isIndexed ) ? @"Yes" : @"No";
		propertyIsOptional.text = ( detailAttributeDescription.isOptional ) ? @"Yes" : @"No";
		propertyIsTransient.text = ( detailAttributeDescription.isTransient ) ? @"Yes" : @"No";
		
		
		attributeType.text = [self nameFromAttributeType:[detailAttributeDescription attributeType]];
		attributeValueClassName.text = [detailAttributeDescription attributeValueClassName];
		attributeValueTransformerName.text = [detailAttributeDescription valueTransformerName];
		
		
		switch ([detailAttributeDescription attributeType]) {
			case NSUndefinedAttributeType:
			case NSBinaryDataAttributeType:
			case NSTransformableAttributeType:
			case NSObjectIDAttributeType:
				attributeDefaultValue.text = @"not used";
				attributeDefaultValue.enabled = NO;
				break;
			case NSStringAttributeType:
				attributeDefaultValue.text = [detailAttributeDescription defaultValue];
				break;
			case NSDateAttributeType:
				attributeDefaultValue.text = [[detailAttributeDescription defaultValue] description];
				break;
			case NSBooleanAttributeType:
				attributeDefaultValue.text = ( [[detailAttributeDescription defaultValue] intValue]  == 1 ) ? @"Yes" : @"No";
				break;
			default:
				attributeDefaultValue.text = [[detailAttributeDescription defaultValue] stringValue];
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
	[super viewDidUnload];
	
	// Release any retained subviews of the main view. Or anything that can be recreated on viewDidLoad
    // e.g. self.myOutlet = nil;
	
	self.relatedEntityName = nil;
	self.propertyIsIndexed = nil;
	self.propertyIsOptional = nil;
	self.propertyIsTransient = nil;
	self.propertyName = nil;
}

- (void) dealloc 
{    
	ERS_RELEASE_SAFELY( detailAttributeDescription );
	
	[super dealloc];
}


@end

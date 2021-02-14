//
//  RssXMLParser.h
//  Sharon Talon
//
//  Created by Amelia Dasari on 12/10/20.
//

#ifndef RssXMLParser_h
#define RssXMLParser_h

#import <Foundation/Foundation.h>

@protocol XMLParserDelegate;

@interface RssXMLParser : NSObject <NSXMLParserDelegate>
{
    //for switch and case
    enum nodes {title = 1, postlink = 2, pubDate = 3, invalidNode = -1};
    enum nodes aNode;

    //for holding the parsing result
    NSMutableDictionary *articles;
    
    //for matching the article title and link
    NSString *lastTitle;
}

@property (assign, nonatomic) id<XMLParserDelegate> delegate;

-(void) parseRssXML: (NSData *)xmldata;
@end

@protocol XMLParserDelegate <NSObject>

@required
- (void) onParserComplete: (NSObject *) data XMLParser: (RssXMLParser *) parser;
@end

#endif /* RssXMLParser_h */

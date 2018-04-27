import React, { Component } from "react";
import PropTypes from "prop-types";
import TextBlock from "./TextBlock.js";
import VocabStore from "./VocabStore.js";
import { DictionaryProvider } from "./Dictionary.js";

class Document extends Component {
  constructor(props) {
    super(props);
    this.updateItemStore = this.tempUpdateItemStore.bind(this);
    this.tempItemStore = {};
  }

  tempUpdateItemStore(key, value) {
    this.tempItemStore[key] = value;
  }
  finalUpdateItemStore(key, value) {
    let item = {};
    item[key] = value;
    this.itemStore.setState(item);
  }

  componentDidMount() {
    this.itemStore.setState(this.tempItemStore);
    this.updateItemStore = this.finalUpdateItemStore.bind(this);
  }

  render() {
    return (
      <div className="ca-document">
        <DictionaryProvider>
          <div className="ca-text">
            {this.props.textBlocks.map((tb, i) => (
              <TextBlock
                segmentationGroups={tb.segmentation_groups}
                key={i}
                id={"tb" + i}
                updateItemStore={this.updateItemStore}
              />
            ))}
          </div>
          <VocabStore
            ref={instance => {
              this.itemStore = instance;
            }}
          />
        </DictionaryProvider>
      </div>
    );
  }
}

Document.propTypes = {
  textBlocks: PropTypes.arrayOf(
    PropTypes.shape({ segmentation_groups: PropTypes.array })
  ).isRequired
};

export default Document;

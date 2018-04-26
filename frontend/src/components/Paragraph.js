import React, { Component } from "react";
import PropTypes from "prop-types";
import SegmentationGroup from "./SegmentationGroup.js";

class Paragraph extends Component {
  render() {
    return (
      <div className="ca-paragraph">
        {this.props.segmentationGroups.map((g, i) => (
          <SegmentationGroup
            inDictionary={g.in_dictionary}
            segmentations={g.segmentations}
            key={i}
            id={this.props.id + "sg" + i}
            updateItemStore={this.props.updateItemStore}
          />
        ))}
      </div>
    );
  }
}

Paragraph.propTypes = {
  segmentationGroups: PropTypes.arrayOf(
    PropTypes.shape({
      in_dictionary: PropTypes.bool,
      segmentations: PropTypes.array
    })
  ).isRequired,
  updateItemStore: PropTypes.func.isRequired
};

export default Paragraph;

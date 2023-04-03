public with sharing class UserService {
    public static List<GroupMember> getGroupMembers(List<User> oldList){
        List<GroupMember> groupMembers = new List<GroupMember>();
        Id idOfGroup = UserSelector.groupIds();
        Id adminProfileId = UserSelector.adimProfileIds();
        for (User user : oldList){
            if (user.ProfileId == adminProfileId && user.IsActive == true) {
                groupMembers.add(new GroupMember(GroupId = IdOfGroup, UserOrGroupId = user.Id));
            }
        }
        return groupMembers;
    }
}